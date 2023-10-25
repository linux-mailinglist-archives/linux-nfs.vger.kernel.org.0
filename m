Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCBF7D72A4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjJYRtx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 13:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjJYRtw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 13:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5067613D
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698256146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SH+1wGQyMKX5piuBbwFtfgeE74L/KQ760RaM70KoaGg=;
        b=K5m/PF+gygSxY039RSUj/+AW8RU8iQBwH3U/c54P1bGYYO0Cs130rvyCgvoVTzShoT/bPm
        Mzn2FCN9m7DrEtx/MFcJsFzbC8+eHeZaKiieuvlARyTFQR4EPM5XtFfWyHnKPiAdsvk6Ds
        R2l3RllgddF1sODMn+kmjSqRguGIdpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-6bWWRbq0PhmgOnTaGEHVBg-1; Wed, 25 Oct 2023 13:49:03 -0400
X-MC-Unique: 6bWWRbq0PhmgOnTaGEHVBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1EBA80D721;
        Wed, 25 Oct 2023 17:49:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8B4271C060AE;
        Wed, 25 Oct 2023 17:49:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Oct 2023 19:48:02 +0200 (CEST)
Date:   Wed, 25 Oct 2023 19:47:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <20231025174758.GB29779@redhat.com>
References: <20231025163006.GA8279@redhat.com>
 <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
 <20231025173931.GA29779@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025173931.GA29779@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

sorry for the noise, forgot to mention.

I personally don't care about nfsd_copy_write_verifier(), and this code doesn't
look really buggy. I am trying to audit the users of read_seqbegin_or_lock(),
see https://lore.kernel.org/all/20231024120808.GA15382@redhat.com/


On 10/25, Oleg Nesterov wrote:
>
> Hi Chuck,
>
> Thanks for your reply. But I am already sleeping and I can't understand it.
> So let me ask a couple of questions.
>
> 1. Do you agree that the current nfsd_copy_write_verifier() code makes no sense?
>
>    I mean, the usage of read_seqbegin_or_lock() suggests that if the lockless
>    pass fails it should take writeverf_lock for writing. But this can't happen,
>    and thus this code doesn't look right no matter what. None of the
>    read_seqbegin_or_lock/need_seqretry/done_seqretry helpers make any sense
>    because "seq" is alway even.
>
> 2. If yes, which change do you prefer? I'd prefer the patch at the end.
>
> Oleg.
>
> On 10/25, Chuck Lever wrote:
> >
> > On Wed, Oct 25, 2023 at 06:30:06PM +0200, Oleg Nesterov wrote:
> > > Hello,
> > >
> > > The usage of writeverf_lock is wrong and misleading no matter what and
> > > I can not understand the intent.
> >
> > The structure of the seqlock was introduced in commit 27c438f53e79
> > ("nfsd: Support the server resetting the boot verifier").
> >
> > The NFS write verifier is an 8-byte cookie that is supposed to
> > indicate the boot epoch of the server -- simply put, when the server
> > restarts, the epoch (and this verifier) changes.
> >
> > NFSv3 and later have a two-phase write scheme where the client
> > sends data to the server (known as an UNSTABLE WRITE), then later
> > asks the server to commit that data (a COMMIT). Before the COMMIT,
> > that data is not durable and the client must hold onto it until
> > the server's COMMIT Reply indicates it's safe for the client to
> > discard that data and move on.
> >
> > When an UNSTABLE WRITE is done, the server reports its current
> > epoch as part of each WRITE Reply. If this verifier cookie changes,
> > the client knows that the server might have lost previously
> > written written-but-uncommitted data, so it must send the WRITEs
> > again in that (rare) case.
> >
> > NFSD abuses this slightly by changing the write verifier whenever
> > there is an underlying local write error that might have occurred in
> > the background (ie, there was no WRITE or COMMIT operation at the
> > time that the server could use to convey the error back to the
> > client). This is supposed to trigger clients to send UNSTABLE WRITEs
> > again to ensure that data is properly committed to durable storage.
> >
> > The point of the seqlock is to ensure that
> >
> > a) a write verifier update does not tear the verifier
> > b) a write verifier read does not see a torn verifier
> >
> > This is a hot path, so we don't want a full spinlock to achieve
> > a) and b).
> >
> > Way back when, the verifier was updated by two separate 32-bit
> > stores; hence the risk of tearing.
> >
> >
> > > nfsd_copy_write_verifier() uses read_seqbegin_or_lock() incorrectly.
> > > "seq" is always even, so read_seqbegin_or_lock() can never take the
> > > lock for writing. We need to make the counter odd for the 2nd round:
> > >
> > > 	--- a/fs/nfsd/nfssvc.c
> > > 	+++ b/fs/nfsd/nfssvc.c
> > > 	@@ -359,11 +359,14 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
> > > 	  */
> > > 	 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
> > > 	 {
> > > 	-	int seq = 0;
> > > 	+	int seq, nextseq = 0;
> > >
> > > 		do {
> > > 	+		seq = nextseq;
> > > 			read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> > > 			memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> > > 	+		/* If lockless access failed, take the lock. */
> > > 	+		nextseq = 1;
> > > 		} while (need_seqretry(&nn->writeverf_lock, seq));
> > > 		done_seqretry(&nn->writeverf_lock, seq);
> > > 	 }
> > >
> > > OTOH. This function just copies 8 bytes, this makes me think that it doesn't
> > > need the conditional locking and read_seqbegin_or_lock() at all. So perhaps
> > > the (untested) patch below makes more sense? Please note that it should not
> > > change the current behaviour, it just makes the code look correct (and more
> > > optimal but this is minor).
> > >
> > > Another question is why we can't simply turn nn->writeverf into seqcount_t.
> > > I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
> > > serialise with itself, right?
> >
> > "reset" is supposed to be very rare operation. Using a lock in that
> > case is probably quite acceptable, as long as reading the verifier
> > is wait-free and guaranteed to be untorn.
> >
> > But a seqcount_t is only 32 bits.
> >
> >
> > > Oleg.
> > > ---
> > >
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index c7af1095f6b5..094b765c5397 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
> > >   */
> > >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
> > >  {
> > > -	int seq = 0;
> > > +	unsigned seq;
> > >
> > >  	do {
> > > -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> > > +		seq = read_seqbegin(&nn->writeverf_lock);
> > >  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> > > -	} while (need_seqretry(&nn->writeverf_lock, seq));
> > > -	done_seqretry(&nn->writeverf_lock, seq);
> > > +	} while (read_seqretry(&nn->writeverf_lock, seq));
> > >  }
> > >
> > >  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
> > >
> >
> > --
> > Chuck Lever
> >

