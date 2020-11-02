Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE552A2EBC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKBP5I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 10:57:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgKBP5I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 10:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604332627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlQdP+NHdz4sW3ghyfembnz7aJOHe9ksWGrnTc0lJnM=;
        b=ZsKBZZkQYDVOi58S9DPb205fBBbxGFpBBZpmGFpUmKOnlDJUy4Azrw7734x1ikd49Ltqhi
        yshfrROU9mcRX7ZMZ9QpHgMVBTSS7qUm6vWZ+3QznjR81lKvTFl78m3CTn/RzjKg0sfv2I
        mLxeVyxpdHwEiAW2XJZzLNyUCXMq4FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-RmsawKb4O1-nLHaJEBSzAQ-1; Mon, 02 Nov 2020 10:57:05 -0500
X-MC-Unique: RmsawKb4O1-nLHaJEBSzAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA5E186840C
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 15:57:05 +0000 (UTC)
Received: from ovpn-112-10.ams2.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A0AF6EF73;
        Mon,  2 Nov 2020 15:57:04 +0000 (UTC)
Message-ID: <1ac387a1ef608258b2e23e7923a1c4e2ec6b25b3.camel@redhat.com>
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Mon, 02 Nov 2020 15:57:02 +0000
In-Reply-To: <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
References: <20201029210401.446244-1-steved@redhat.com>
         <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
         <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
         <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-02 at 09:23 -0500, Steve Dickson wrote:
> Hello,
> 
> On 11/2/20 8:24 AM, Steve Dickson wrote:
> > > You would need to write an equivalent of conf_load_file() that
> > > created a new transaction id and read in all the files before
> > > committing them to do it this way.
> > 

How about the following as an alternative...

It changes none of the past behaviour, but if you wanted to add an
optional directory structure to a config file then simply add this to
the default single config file that we ship.

/etc/nfsmount.conf:
[NFSMount_Global_Options]
include=-/etc/nfsmount.conf.d/*.conf


The leading minus tells it that it isnt an error if its empty, and it
will load all of the fragments it finds in there as well as the
existing single file.  Apply the same structure to any existing config
file that you want to also have a directory for.

-Alice



diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 58c03911..aade50c8 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -53,6 +53,7 @@
 #include <libgen.h>
 #include <sys/file.h>
 #include <time.h>
+#include <glob.h>
 
 #include "conffile.h"
 #include "xlog.h"
@@ -690,6 +691,7 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
 	if (strcasecmp(line, "include")==0) {
 		/* load and parse subordinate config files */
 		_Bool optional = false;
+		glob_t globdata;
 
 		if (val && *val == '-') {
 			optional = true;
@@ -704,33 +706,46 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
 			return;
 		}
 
-		subconf = conf_readfile(relpath);
-		if (subconf == NULL) {
-			if (!optional)
-				xlog_warn("config error at %s:%d: error loading included config",
-					  filename, lineno);
-			if (relpath)
-				free(relpath);
-			return;
-		}
+		if (glob(relpath, GLOB_MARK|GLOB_NOCHECK, NULL, &globdata)) {
+			xlog_warn("config error at %s:%d: error with matching pattern", filename, lineno);
+		} else 
+		{
+			for (size_t g=0; g<globdata.gl_pathc; g++) {
+				const char * subpath = globdata.gl_pathv[g];
 
-		/* copy the section data so the included file can inherit it
-		 * without accidentally changing it for us */
-		if (*section != NULL) {
-			inc_section = strdup(*section);
-			if (*subsection != NULL)
-				inc_subsection = strdup(*subsection);
-		}
+				if (subpath[strlen(subpath)-1] == '/') {
+					continue;
+				}
+				subconf = conf_readfile(subpath);
+				if (subconf == NULL) {
+					if (!optional)
+						xlog_warn("config error at %s:%d: error loading included config",
+							  filename, lineno);
+					if (relpath)
+						free(relpath);
+					return;
+				}
+
+				/* copy the section data so the included file can inherit it
+				 * without accidentally changing it for us */
+				if (*section != NULL) {
+					inc_section = strdup(*section);
+					if (*subsection != NULL)
+						inc_subsection = strdup(*subsection);
+				}
 
-		conf_parse(trans, subconf, &inc_section, &inc_subsection, relpath);
+				conf_parse(trans, subconf, &inc_section, &inc_subsection, relpath);
 
-		if (inc_section)
-			free(inc_section);
-		if (inc_subsection)
-			free(inc_subsection);
+				if (inc_section)
+					free(inc_section);
+				if (inc_subsection)
+					free(inc_subsection);
+				free(subconf);
+			}
+		}
 		if (relpath)
 			free(relpath);
-		free(subconf);
+		globfree(&globdata);
 	} else {
 		/* XXX Perhaps should we not ignore errors?  */
 		conf_set(trans, *section, *subsection, line, val, 0, 0);


