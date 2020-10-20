Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D329416A
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395509AbgJTRZv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 13:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395507AbgJTRZv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Oct 2020 13:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603214749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyg4kF7wr6hDZNrj+kOdXxFzymsno8LwUyVBSeyImtc=;
        b=hDGZNvb5egi9Bnvj46Nm9YMOlWQz6qwKpKC2Ffm3UCGpq0j2IM2V7OltDvnwFqCJehgV+l
        tzoQz/AdKdCbRwC7jZARox0EvJrsuVHVXiESRSBBD3z9BJ356cEL19pS6+PQBkhqWbclmD
        NhIbXWh66PsQ2FxLie46CD9/1jByJOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-s2nAit2eM-GJykypgOGffw-1; Tue, 20 Oct 2020 13:25:47 -0400
X-MC-Unique: s2nAit2eM-GJykypgOGffw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3EFFAD740;
        Tue, 20 Oct 2020 17:25:46 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-114-37.phx2.redhat.com [10.3.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A38ED6EF6D;
        Tue, 20 Oct 2020 17:25:46 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] nfsdcld: update tool name in man page.
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <87y2krhjnx.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <be321e2f-a16d-c8d9-1a07-9b73b76315d1@RedHat.com>
Date:   Tue, 20 Oct 2020 13:25:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87y2krhjnx.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/30/20 2:18 AM, NeilBrown wrote:
> 
> clddb-tool was recently renamed to nfsdclddb.
> Unfortunately the nfsdcld man page wasn't told.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  utils/nfsdcld/nfsdcld.man | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Committed... (tag nfs-utils-2-5-2-rc6)

steved.
> 
> diff --git a/utils/nfsdcld/nfsdcld.man b/utils/nfsdcld/nfsdcld.man
> index 4c2b1e80a2a8..861f1c49efec 100644
> --- a/utils/nfsdcld/nfsdcld.man
> +++ b/utils/nfsdcld/nfsdcld.man
> @@ -209,12 +209,12 @@ not necessary after upgrading \fBnfsdcld\fR, however \fBnfsd\fR will not use a l
>  version until restart.  A restart of \fBnfsd is necessary\fR after downgrading \fBnfsdcld\fR,
>  to ensure that \fBnfsd\fR does not use an upcall version that \fBnfsdcld\fR does not support.
>  Additionally, a downgrade of \fBnfsdcld\fR requires the schema of the on-disk database to
> -be downgraded as well.  That can be accomplished using the \fBclddb-tool\fR(8) utility.
> +be downgraded as well.  That can be accomplished using the \fBnfsdclddb\fR(8) utility.
>  .SH FILES
>  .TP
>  .B /var/lib/nfs/nfsdcld/main.sqlite
>  .SH SEE ALSO
> -.BR nfsdcltrack "(8), " clddb-tool (8)
> +.BR nfsdcltrack "(8), " nfsdclddb (8)
>  .SH "AUTHORS"
>  .IX Header "AUTHORS"
>  The nfsdcld daemon was developed by Jeff Layton <jlayton@redhat.com>
> 

