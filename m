Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD94A90E4
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Feb 2022 23:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355898AbiBCWvz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Feb 2022 17:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241561AbiBCWvy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Feb 2022 17:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643928714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XBV9uZIGSDRirZPLw7cWdCx5AQAJiG3Ym3YYnGsINmk=;
        b=ig57jHvFrYW9qGi69Y1LY8zWMORe8jNLEMhjNtIkLbE759OPQbWzCoxBUbYWOercSZbdWx
        qnMrDtoJzLo6C27FjhJzr+mcdx5FQW5Ru8TodPVlO7tT4aG1xsARyxLjXaAt9cguSe8KKL
        heQZoTVaOcciGPgx7ydDdsbl+zXUcqo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-jwgHMmHPPUq0asSjL1viAw-1; Thu, 03 Feb 2022 17:51:53 -0500
X-MC-Unique: jwgHMmHPPUq0asSjL1viAw-1
Received: by mail-qk1-f200.google.com with SMTP id p23-20020a05620a15f700b00506d8ec3749so2664192qkm.4
        for <linux-nfs@vger.kernel.org>; Thu, 03 Feb 2022 14:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XBV9uZIGSDRirZPLw7cWdCx5AQAJiG3Ym3YYnGsINmk=;
        b=ALmk8UURT++t/7OPAckzvQe2CBs0dbcSSxqz9Xud+FkbWNyE6m1vQyI+d0HlSRcE2n
         xQE0N+cPhxrlTpjGrrkTCl09GIOJgcrRFVZhsa44qS0QFZVXtsFyKk0BYvSrmf8zHrVc
         MpNmTjC/HLvDJ+x7gFn2eWvxGWqOHHH0Jvt7TwA41yKlc/j14kFRAQlg+P/7cupvW6Cp
         g6F1QJrGDioslAYW3Dfjuf4IhKbcZgg3HgjCilEEmmCHoSAtiK7KScEsOVp8RNcK1MBq
         ok6LYdL1cYdzVBvDa+Grtkpl9Mihg2Do4jxMkKZM517uXO5dpxk0t6fW+E6AF4LaCgeZ
         0QwQ==
X-Gm-Message-State: AOAM530wjj6I2cU44AsPrJUwg7j0Lrmz+ABWNdaKawadgeA5HwshvIbF
        mX60bUQ2dvauZgNM9ahufFwC5bCrZ2Z+AG4fcyXNIysaweFu0rOf9Zg9ezmv47QiFp7L4X7cKau
        xHHlHqGp8pNj0bRtNOAsK
X-Received: by 2002:ac8:580e:: with SMTP id g14mr254080qtg.263.1643928712773;
        Thu, 03 Feb 2022 14:51:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhwyU7hHVF2fyZKG4y1vhn1TMW9JxaNA1lIee+oAn4rSfcwiZqa0GwZy5V13PBZiFul5LmqQ==
X-Received: by 2002:ac8:580e:: with SMTP id g14mr254074qtg.263.1643928712592;
        Thu, 03 Feb 2022 14:51:52 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id e9sm156784qtx.37.2022.02.03.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 14:51:52 -0800 (PST)
Message-ID: <a963b98f7f3cc31ad982c9be4ed6def21cd40c84.camel@redhat.com>
Subject: Re: [PATCH RFC 2/3] fs/lock: only call lm_breaker_owns_lease if
 there is conflict.
From:   Jeff Layton <jlayton@redhat.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        bfields@fieldses.org
Cc:     viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 03 Feb 2022 17:51:51 -0500
In-Reply-To: <1643398773-29149-3-git-send-email-dai.ngo@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
         <1643398773-29149-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-01-28 at 11:39 -0800, Dai Ngo wrote:
> Modify leases_conflict to call lm_breaker_owns_lease only if
> there is real conflict.  This is to allow the lock manager to
> resolve the conflict if possible.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/locks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 052b42cc7f25..456717873cff 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1357,9 +1357,6 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
>  {
>  	bool rc;
>  
> -	if (lease->fl_lmops->lm_breaker_owns_lease
> -			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
> -		return false;
>  	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
>  		rc = false;
>  		goto trace;
> @@ -1370,6 +1367,9 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
>  	}
>  
>  	rc = locks_conflict(breaker, lease);
> +	if (rc && lease->fl_lmops->lm_breaker_owns_lease &&
> +		lease->fl_lmops->lm_breaker_owns_lease(lease))
> +		rc = false;
>  trace:
>  	trace_leases_conflict(rc, lease, breaker);
>  	return rc;

Acked-by: Jeff Layton <jlayton@redhat.com>

