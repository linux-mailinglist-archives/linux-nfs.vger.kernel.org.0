Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780F3D8C8B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jul 2021 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhG1LQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jul 2021 07:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhG1LQA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Jul 2021 07:16:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 573966054E;
        Wed, 28 Jul 2021 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627470959;
        bh=0iAbzfcTbMKwEwjJ5/Jq/q6tiVMD/Ve5LOR80V4dH5Y=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=acPkQ7UflJ1Qo7jL2VLJq+lKViRbMwhj33Gi7G7S9j+S0ueXyx1ER9peFdkOeHIcS
         cVii64vFfDvXwwJI88sd3BYrKaXGM+cBdL4xzwgrbjw/ZsuMeqn80depVAGyTgDCwG
         m3W1Mjnr2GeHF+rV20G5KXE+xx7m9GVeew6ZXWbOf+t3Tze5vYDo7xS03jKkM/k0CJ
         4MufMRha9oMcEgckXuWv2fXRB2FtV7MqTK/D+96EUc47enkxYp2D6cytpvtWUa/fB3
         FpKRyvbFKpFfjMp0ReEyXEmD+teyiMl7tGPXwj10wuPeFQYjFiAWvm9HXyTzxKVhpq
         iSpm3tbxq8+Tg==
Message-ID: <0ba5eaacd17a50b0ab0c6fd9605a7c330935eca8.camel@kernel.org>
Subject: Re: [PATCH] nfsdcltrack: Use uint64_t instead of time_t
From:   Jeff Layton <jlayton@kernel.org>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Date:   Wed, 28 Jul 2021 07:15:58 -0400
In-Reply-To: <20210728013608.167759-1-steved@redhat.com>
References: <20210728013608.167759-1-steved@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2021-07-27 at 21:36 -0400, Steve Dickson wrote:
> With recent commits (4f2a5b64,5a53426c) that fixed
> compile errors on x86_64 machines, caused similar
> errors on i686 machines.
> 
> The variable type that was being used was a time_t,
> which changes size between architects, which
> caused the compile error.
> 
> Changing the variable to uint64_t fixed the issue.
> 
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  utils/nfsdcltrack/nfsdcltrack.c | 2 +-
>  utils/nfsdcltrack/sqlite.c      | 2 +-
>  utils/nfsdcltrack/sqlite.h      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
> index 0b37c094..7c1c4bcc 100644
> --- a/utils/nfsdcltrack/nfsdcltrack.c
> +++ b/utils/nfsdcltrack/nfsdcltrack.c
> @@ -508,7 +508,7 @@ cltrack_gracedone(const char *timestr)
>  {
>  	int ret;
>  	char *tail;
> -	time_t gracetime;
> +	uint64_t gracetime;
>  

Hmm.. time_t is a long:

    typedef __kernel_long_t __kernel_time_t;

...but the kernel is converting this value from a time64_t which is s64.
 
Should the above be int64_t instead of being unsigned? The kernel should
never send down a negative value, but if you're trying to match up types
then that might be cleaner.

> 
>  	ret = sqlite_prepare_dbh(storagedir);
> diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
> index cea4a411..cf0c6a45 100644
> --- a/utils/nfsdcltrack/sqlite.c
> +++ b/utils/nfsdcltrack/sqlite.c
> @@ -540,7 +540,7 @@ out_err:
>   * remove any client records that were not reclaimed since grace_start.
>   */
>  int
> -sqlite_remove_unreclaimed(time_t grace_start)
> +sqlite_remove_unreclaimed(uint64_t grace_start)
>  {
>  	int ret;
>  	char *err = NULL;
> diff --git a/utils/nfsdcltrack/sqlite.h b/utils/nfsdcltrack/sqlite.h
> index 06e7c044..ba8cdfa8 100644
> --- a/utils/nfsdcltrack/sqlite.h
> +++ b/utils/nfsdcltrack/sqlite.h
> @@ -26,7 +26,7 @@ int sqlite_insert_client(const unsigned char *clname, const size_t namelen,
>  int sqlite_remove_client(const unsigned char *clname, const size_t namelen);
>  int sqlite_check_client(const unsigned char *clname, const size_t namelen,
>  				const bool has_session);
> -int sqlite_remove_unreclaimed(const time_t grace_start);
> +int sqlite_remove_unreclaimed(const uint64_t grace_start);
>  int sqlite_query_reclaiming(const time_t grace_start);
>  
>  #endif /* _SQLITE_H */

-- 
Jeff Layton <jlayton@kernel.org>

