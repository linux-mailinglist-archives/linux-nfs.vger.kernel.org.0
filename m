Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2048A3AC
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 00:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiAJXbi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 18:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiAJXbi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 18:31:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11778C06173F;
        Mon, 10 Jan 2022 15:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C687FB8181E;
        Mon, 10 Jan 2022 23:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A948C36AE5;
        Mon, 10 Jan 2022 23:31:35 +0000 (UTC)
Date:   Mon, 10 Jan 2022 18:31:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix sockaddr handling in NFSD trace points
Message-ID: <20220110183133.78098878@gandalf.local.home>
In-Reply-To: <20220110110535.25ca51bf@gandalf.local.home>
References: <164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net>
        <20220110110535.25ca51bf@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 10 Jan 2022 11:05:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I haven't quite been able to figure out how to handle the 
> > TP_printk() part of this equation. `trace-cmd report` displays
> > something like "addr=ARG TYPE NOT FIELD BUT 7". 
> > 
> > Thoughts or advice appreciated.  
> 
> I'll take a look into it.

If you add this to libtraceevent, it will work:

diff --git a/src/event-parse.c b/src/event-parse.c
index 9bd605d..033529c 100644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -5127,6 +5127,8 @@ static int print_ipsa_arg(struct trace_seq *s, const char *ptr, char i,
 	unsigned char *buf;
 	struct sockaddr_storage *sa;
 	bool reverse = false;
+	unsigned int offset;
+	unsigned int len;
 	int rc = 0;
 	int ret;
 
@@ -5152,27 +5154,42 @@ static int print_ipsa_arg(struct trace_seq *s, const char *ptr, char i,
 		return rc;
 	}
 
-	if (arg->type != TEP_PRINT_FIELD) {
-		trace_seq_printf(s, "ARG TYPE NOT FIELD BUT %d", arg->type);
-		return rc;
-	}
+	/* evaluate if the arg has a typecast */
+	while (arg->type == TEP_PRINT_TYPE)
+		arg = arg->typecast.item;
+
+	if (arg->type == TEP_PRINT_FIELD) {
 
-	if (!arg->field.field) {
-		arg->field.field =
-			tep_find_any_field(event, arg->field.name);
 		if (!arg->field.field) {
-			do_warning("%s: field %s not found",
-				   __func__, arg->field.name);
-			return rc;
+			arg->field.field =
+				tep_find_any_field(event, arg->field.name);
+			if (!arg->field.field) {
+				do_warning("%s: field %s not found",
+					   __func__, arg->field.name);
+				return rc;
+			}
 		}
+
+		offset = arg->field.field->offset;
+		len = arg->field.field->size;
+
+	} else if (arg->type == TEP_PRINT_DYNAMIC_ARRAY) {
+
+		dynamic_offset_field(event->tep, arg->dynarray.field, data,
+				     size, &offset, &len);
+
+	} else {
+		trace_seq_printf(s, "ARG NOT FIELD NOR DYNAMIC ARRAY BUT TYPE %d",
+				 arg->type);
+		return rc;
 	}
 
-	sa = (struct sockaddr_storage *) (data + arg->field.field->offset);
+	sa = (struct sockaddr_storage *)(data + offset);
 
 	if (sa->ss_family == AF_INET) {
 		struct sockaddr_in *sa4 = (struct sockaddr_in *) sa;
 
-		if (arg->field.field->size < sizeof(struct sockaddr_in)) {
+		if (len < sizeof(struct sockaddr_in)) {
 			trace_seq_printf(s, "INVALIDIPv4");
 			return rc;
 		}
@@ -5185,7 +5202,7 @@ static int print_ipsa_arg(struct trace_seq *s, const char *ptr, char i,
 	} else if (sa->ss_family == AF_INET6) {
 		struct sockaddr_in6 *sa6 = (struct sockaddr_in6 *) sa;
 
-		if (arg->field.field->size < sizeof(struct sockaddr_in6)) {
+		if (len < sizeof(struct sockaddr_in6)) {
 			trace_seq_printf(s, "INVALIDIPv6");
 			return rc;
 		}
