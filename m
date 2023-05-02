Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9776F4C37
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjEBV32 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 17:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEBV31 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 17:29:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AF10EF
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 14:29:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C68B21D22;
        Tue,  2 May 2023 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683062962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sG6WHGJQcQxYGpSAoN960cT8xZf37IXk1B9897z2Zuk=;
        b=HP1LQmB+zc6G45FG8S+hB+DMjVq5s/Ickk2VCU0cqtD3578TuKwleTeM19mgUrTRMLecJs
        BqzHZDAhlZ+4qqk6M1SDuojmVkFz08doZjWAaBjCfBcekR7NvRyg5un5zm05E1biqgQjoL
        ZxaV7D+QXVIgVxrO36IoWyLh29wWpeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683062962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sG6WHGJQcQxYGpSAoN960cT8xZf37IXk1B9897z2Zuk=;
        b=QuB9I0A+vjAenyFUZsZtGNdK+hBJJaHWc8qfYlB+2OAlbm3hpkhzyd8ar+3HNh9dMdsnl5
        ceTWXFa/H/F/5uDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09726139C3;
        Tue,  2 May 2023 21:29:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yS2ELK+AUWTDSgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 02 May 2023 21:29:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Steve Dickson" <SteveD@redhat.com>,
        "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept methods
In-reply-to: <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>,
 <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>,
 <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>,
 <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
Date:   Wed, 03 May 2023 07:29:16 +1000
Message-id: <168306295699.19756.6936046274590747287@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 03 May 2023, Chuck Lever III wrote:
>=20
> > On May 2, 2023, at 7:01 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
>=20
> > as it breaks nfs3-only servers in 6.3. I.e. /etc/nfs.conf containing:
> > [nfsd]
> > vers4=3Dno
>=20
> Note: Changing the settings in /etc/nfs.conf had no effect
> on my server, so I effected the change by stopping the
> server and poking values into /proc/fs/nfsd/versions by
> hand.
>=20
> Steve?

Fixed in nfs-utils-2-3-4-rc1~7
  Commit: d68be5d6ae50 ("nfs.conf: fail to disable major NFS version 4 using =
"vers4=3Dn" in /etc/nfs.conf")

NeilBrown
