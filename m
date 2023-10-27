Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AAE7DA3C0
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Oct 2023 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjJ0WwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjJ0WwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 18:52:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8A1B6;
        Fri, 27 Oct 2023 15:52:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E2601FEF5;
        Fri, 27 Oct 2023 22:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698447132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omRuHwL6dEn0kqkZMYcSf7jMW/KbFdLyh/lKeGTZ3o4=;
        b=E7jUejb+HWyZmM4Qf5L/9K9ECtYnwhEpFWbRxJFPx5lj7ixXmk+PEzQHuhx4k962PuBXna
        xjMn1KaclsVYh4kIS9lvl2NmJYoVFYN0s8LaLMkWraKGPyTGmOwyl9xMKm2G1V0nzDi5eE
        TeJH0X+53FJM0fYI0U4Xp4pyC96rwV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698447132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=omRuHwL6dEn0kqkZMYcSf7jMW/KbFdLyh/lKeGTZ3o4=;
        b=fq7O0bXM9HXoMJ2jvAl9yGNwLPxGpkmKuF2riOEoimI80+JokjMUoX7PzUORwHMiGgos0B
        MkZwiglixLuRK2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8F0613524;
        Fri, 27 Oct 2023 22:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fKd0Ihg/PGWPRgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 22:52:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Oleg Nesterov" <oleg@redhat.com>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "Ingo Molnar" <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather than
 read_seqbegin_or_lock()
In-reply-to: <20231026145018.GA19598@redhat.com>
References: <20231025163006.GA8279@redhat.com>, <20231026145018.GA19598@redhat.com>
Date:   Sat, 28 Oct 2023 09:52:05 +1100
Message-id: <169844712523.20306.8210786436807794776@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Oct 2023, Oleg Nesterov wrote:
> The usage of read_seqbegin_or_lock() in nfsd_copy_write_verifier()
> is wrong. "seq" is always even and thus "or_lock" has no effect,
> this code can never take ->writeverf_lock for writing.
> 
> I guess this is fine, nfsd_copy_write_verifier() just copies 8 bytes
> and nfsd_reset_write_verifier() is supposed to be very rare operation
> so we do not need the adaptive locking in this case.
> 
> Yet the code looks wrong and sub-optimal, it can use read_seqbegin()
> without changing the behaviour.

Wow! read_seqbegin_or_lock() has never locked since

Commit: 88a411c07b6f ("seqlock: livelock fix") in Linux v2.6.26 (2008).

That's rather embarrassing.

I agree we don't need the lock on the read-side for nfsd.

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown


> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/nfsd/nfssvc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..094b765c5397 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
>   */
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
>  {
> -	int seq = 0;
> +	unsigned seq;
>  
>  	do {
> -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> +		seq = read_seqbegin(&nn->writeverf_lock);
>  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> -	} while (need_seqretry(&nn->writeverf_lock, seq));
> -	done_seqretry(&nn->writeverf_lock, seq);
> +	} while (read_seqretry(&nn->writeverf_lock, seq));
>  }
>  
>  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
> -- 
> 2.25.1.362.g51ebf55
> 
> 
> 

