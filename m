Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72BB226261
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgGTOoE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 10:44:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32382 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgGTOoE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595256243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqI4rbHeA8bhdcPTa+ROldnRbzJUJ3A4tkvDZuFs7Mo=;
        b=LsHyFND/fMftX/Y30x53Yp3FV3qcyQLRKG07otrKkBt37TGVQgGv6ODPZO+dY2zvCrrP7v
        HizpcfBKueZOJfxFTzjxLrMKwDkiCfn2oqxfuzjMR6iomS46bwfKhAER4xRB9/qsFCn5Zk
        rzZecdYvQYAXg4A+yVEMOqruFwIoTgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371--XSt_6MxNDS_Tiy-Y7P3JQ-1; Mon, 20 Jul 2020 10:44:00 -0400
X-MC-Unique: -XSt_6MxNDS_Tiy-Y7P3JQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1AB680046C;
        Mon, 20 Jul 2020 14:43:58 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7B95FC31;
        Mon, 20 Jul 2020 14:43:58 +0000 (UTC)
Subject: Re: [PATCH 02/11] gssd: Fix cccache buffer size
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-3-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <fa7a464f-3749-b8d8-bf92-02173a03dffb@RedHat.com>
Date:   Mon, 20 Jul 2020 10:43:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200718092421.31691-3-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Doug,

On 7/18/20 5:24 AM, Doug Nazar wrote:
> Signed-off-by: Doug Nazar <nazard@nazar.ca>
> ---
>  utils/gssd/krb5_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
> index e5b81823..34c81daa 100644
> --- a/utils/gssd/krb5_util.c
> +++ b/utils/gssd/krb5_util.c
> @@ -1225,7 +1225,7 @@ out:
>  int
>  gssd_setup_krb5_user_gss_ccache(uid_t uid, char *servername, char *dirpattern)
>  {
> -	char			buf[PATH_MAX+2+256], dirname[PATH_MAX];
> +	char			buf[PATH_MAX+4+2+256], dirname[PATH_MAX];
>  	const char		*cctype;
>  	struct dirent		*d;
>  	int			err, i, j;
> 
Thanks for point this out but I think I'm going to go with this:

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index e5b8182..cd5a919 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -223,7 +223,8 @@ gssd_find_existing_krb5_ccache(uid_t uid, char *dirname,
 	int found = 0;
 	struct dirent *best_match_dir = NULL;
 	struct stat best_match_stat, tmp_stat;
-	char buf[PATH_MAX+4+2+256];
+	/* dirname + cctype + d_name + NULL */
+	char buf[PATH_MAX+5+256+1];
 	char *princname = NULL;
 	char *realm = NULL;
 	int score, best_match_score = 0, err = -EACCES;
@@ -1225,7 +1226,8 @@ out:
 int
 gssd_setup_krb5_user_gss_ccache(uid_t uid, char *servername, char *dirpattern)
 {
-	char			buf[PATH_MAX+2+256], dirname[PATH_MAX];
+				/* dirname + cctype + d_name + NULL */
+	char			buf[PATH_MAX+5+256+1], dirname[PATH_MAX];
 	const char		*cctype;
 	struct dirent		*d;
 	int			err, i, j;

which explains the needed space and as well removes the warning... 

steved

