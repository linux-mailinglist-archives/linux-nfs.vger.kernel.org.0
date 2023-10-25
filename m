Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6447D7615
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJYUzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYUzC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 16:55:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D446413D
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 13:54:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51A1B200B4;
        Wed, 25 Oct 2023 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698267297;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HggZWvf/g1tenz6t9mJ0txCKXxT+vX6kjsITziXOsIk=;
        b=W06d8ZVL2Ri8AvWgtxs1Io1tL594yhy7YbwMy6y5bvP02jvB+ReYydNfhGsn2PtiW3Eqou
        PEW6kRKHImwY3k2RU/fxnpVewwkajOWlpP86UAT2Ur5BqySvZDUGwyOgRRVQ2fm8fF3Sm0
        XYWyuF0DtW3kQV1+SUlg1Gb64gE55Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698267297;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HggZWvf/g1tenz6t9mJ0txCKXxT+vX6kjsITziXOsIk=;
        b=mwHe240nalPy/27CAK5GaW6KDLuTCWVfeqMXqEx14qKDFudo+/rnm+VZQbcw0AQ2tl01SE
        EoDXx8n81ytv5NDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1418513524;
        Wed, 25 Oct 2023 20:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ecJCA6GAOWWiKQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 20:54:57 +0000
Date:   Wed, 25 Oct 2023 22:54:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 0/3] Add getrandom() fallback, cleanup headers
Message-ID: <20231025205455.GA460410@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231025194701.456031-1-pvorel@suse.cz>
 <857096093.3016.1698264780882.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <857096093.3016.1698264780882.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Richard,

> ----- Ursprüngliche Mail -----
> > Von: "Petr Vorel" <pvorel@suse.cz>
> > I also wonder why getrandom() syscall does not called with GRND_NONBLOCK
> > flag. Is it ok/needed to block?

> With GRND_NONBLOCK it would return EAGAIN if not enough
> randomness is ready. How to handle this then? Aborting the start of the daemon?

Well, current code uses /dev/urandom and blocks until pool is ready (man
random(7)), which is probably OK (on VM people may need to use haveged to avoid
blocking, but that's known). But even with blocking mode blocking requests of
any size can be interrupted by a signal handler with errno EINTR. That's
probably the reason why people write more robust code. I'm not sure if it's
really needed to be handled in our case.

Nice example is ul_random_get_bytes() in util-linux [1]:

#ifdef HAVE_GETRANDOM
	while (n > 0) {
		int x;

		errno = 0;
		x = getrandom(cp, n, GRND_NONBLOCK);
		if (x > 0) {			/* success */
		       n -= x;
		       cp += x;
		       lose_counter = 0;
		       errno = 0;
		} else if (errno == ENOSYS) {	/* kernel without getrandom() */
			break;

		} else if (errno == EAGAIN && lose_counter < UL_RAND_READ_ATTEMPTS) {
			xusleep(UL_RAND_READ_DELAY);	/* no entropy, wait and try again */
			lose_counter++;
		} else
			break;
	}

	if (errno == ENOSYS)
#endif

1) sleep on EAGAIN and try again (needed to be handled due GRND_NONBLOCK).

2) It also handles ENOSYS (run on kernel without getrandom() although it was built
with libc support), which would be very rare (IMHO getrandom() is on all
architectures, but looking into drivers/char/random.c, it would be on kernels
without CONFIG_SYSCTL).  Then the code also adds fallback to read
/dev/{u,}random in this case. It could be added to nfs-utils, if anybody really
needs it.

> Before we other think the whole thing, the sole purpose of the getrandom()
> call is seeding libc's PRNG with srand() to give every waiter a different
> amount of sleep time upon concurrent database access.
> See wait_for_dbaccess() and handling of SQLITE_LOCKED.

> I'm pretty sure instead of seeding from getrandom() we can also use the current
> time or read a few bytes from /dev/urandom.

Sure. Current time would work everywhere, but I guess getrandom() with syscall
is good enough. Systems which have /dev/urandom also have getrandom() syscall
(thus will work with my current proposal).

> Just make sure that every user of sqlite_plug_init() has a different seed.

Thanks for info.

Kind regards,
Petr

> Thanks,
> //richard

[1] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/lib/randutils.c
