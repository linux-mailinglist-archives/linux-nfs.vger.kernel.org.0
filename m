Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5938CCEA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 20:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhEUSJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 14:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238544AbhEUSJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 14:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621620464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zy80uNvcORRYlo0Wl+ZUij0Ne2Up/XLBiXty2kC5rXg=;
        b=XUr9TbpqiNNKyY4tzzt385zR6wZStT4HshzSS0QONiTw9qT0EpTwP7ISWsMy52Jy5JMLU3
        2sphc0e+5PFCIswhPVFi7Q4IC9rW2FGLkcZcj2B6nps6Ka/jgLwmnu4dofxV+sX6PRwm5x
        VuRpUS7tSTrMkG6FaWY6Q9HKgz83SxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ijfC65jcOeCijkhay_xFnw-1; Fri, 21 May 2021 14:07:40 -0400
X-MC-Unique: ijfC65jcOeCijkhay_xFnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43F1A800C60;
        Fri, 21 May 2021 18:07:39 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-99.phx2.redhat.com [10.3.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B99D5D6CF;
        Fri, 21 May 2021 18:07:38 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 8B639120966; Fri, 21 May 2021 14:07:37 -0400 (EDT)
Date:   Fri, 21 May 2021 14:07:37 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Tom Haynes <loghyr@hammerspace.com>,
        "Yong Sun (Sero)" <yosun@suse.com>
Subject: Re: [PATCH pynfs 2/2] 4.1 server: Compare with int variable instead
 of string
Message-ID: <YKf26VaDUVmsr2bx@pick.fieldses.org>
References: <20210521054633.3170-1-pvorel@suse.cz>
 <20210521054633.3170-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521054633.3170-2-pvorel@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Both applied, thanks.--b.

On Fri, May 21, 2021 at 07:46:33AM +0200, Petr Vorel wrote:
> Similarly to previous commit prefer using int variables
> (e.g. NFS4_OK) than string literals (e.g. "NFS4_OK"),
> which don't detect typos.
> 
> This requires to change status parameter of show_op()
> from string to int.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  nfs4.1/nfs4server.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/nfs4.1/nfs4server.py b/nfs4.1/nfs4server.py
> index 6f7d10c..9422481 100755
> --- a/nfs4.1/nfs4server.py
> +++ b/nfs4.1/nfs4server.py
> @@ -515,8 +515,8 @@ class SummaryOutput:
>  
>          summary_line = "  %s" % ', '.join(opnames)
>  
> -        if status != "NFS4_OK" and status != "NFS3_OK":
> -            summary_line += " -> %s" % (status,)
> +        if status != NFS4_OK and status != NFS3_OK:
> +            summary_line += " -> %s" % nfsstat4[status]
>  
>          print_summary_line = True
>          if summary_line != self._last or role != self._last_role:
> @@ -850,7 +850,7 @@ class NFS4Server(rpc.Server):
>          log_41.info("Replying.  Status %s (%d)" % (nfsstat4[status], status))
>          client_addr = '%s:%s' % cred.connection._s.getpeername()[:2]
>          self.summary.show_op('handle v4.1 %s' % client_addr,
> -                             opnames, nfsstat4[status])
> +                             opnames, status)
>          return env
>  
>      def delete_session(self, session, sessionid):
> -- 
> 2.31.1
> 

