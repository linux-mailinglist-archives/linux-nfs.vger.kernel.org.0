Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095976AEB5E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Mar 2023 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjCGRnx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Mar 2023 12:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCGRn2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Mar 2023 12:43:28 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289DE9CBCC
        for <linux-nfs@vger.kernel.org>; Tue,  7 Mar 2023 09:39:30 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-53d277c1834so82336787b3.10
        for <linux-nfs@vger.kernel.org>; Tue, 07 Mar 2023 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1678210763;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yKJ1xnLvZwucLv+2Y8pUPYv8nLOOyK0pjzTdrCv/Nvk=;
        b=WC7B2nu/JFqbJfuLcWrxbAW3K1A0nXmyYBI60rVjFALCyKcygCcgGnQ7NXJ57S4lB5
         fEBUA8EdiBo1FpQNvazINvYUEeO7rd1whK0nZjN6hqAWcZIlb97kmPpVQDE15S0xN4Mk
         29FY+i2AkJ7m3Y9/CqQtEJtUBoD8bKCF7a5s3kqxAWlmQDbbEUrOgi6pL5xAjkF2HhLT
         RH8VOwEtAwF0NSPRjlCnma4RejxnDAzsLWdOKB5JUye/azDNFy5mLPgmSFb3abzRQ++G
         syWM3hw3LxNtzhXHCm8UuYphL6yOIpzWSEWrZT8IQ+MAHgkt2jxkPQqLb7qBQc126Y2n
         h0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210763;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKJ1xnLvZwucLv+2Y8pUPYv8nLOOyK0pjzTdrCv/Nvk=;
        b=uVQakleru6VI9L4y5Zkv4lOJ+QIB8bBf11NBWTRtkQ8toN+YJTN0OGVPGf1dJv3R2R
         +6rgSg8WMN6sBvPAhOUUNHvRK5fmXWK4AV+yoevi8HuuTGaE2IpLUDnSfNfiPdhPOmbi
         X0LqfjHtREUMi4jTpnkpZPROPzj8SpL3F9mcx2wMNggqo43koqn4qrq4d+E3a76xSlzf
         1uryeXmFvjVQHpPGmXp4ph3tHesKElg3JFKT+c0TbDXcI6ZVjMLtHr9BMK5jBy0me5SU
         oIzL8SaNJlIygpNdRd84gA+grSs8CHYLaCbhGqyckJbX86G6NbFS967PdniHFURPTojg
         FhAg==
X-Gm-Message-State: AO0yUKUuOP92FkIjZ7ugL0w7LO7y+rbV0/8Pb28WZkVY8eODqvR7Anc2
        CRhvkTGu8XNwD/rH8/PTnmkKmLOBFvgWe4aHNsUc6/AEFQZz02qFZg0=
X-Google-Smtp-Source: AK7set+Og5xVamBh4Vd1gJuyh7nbkgynmnF1xtE5go6HJ3oOlssbxIcGk9fSSEdHBkjoVtKBPy9wmJH4NLmZCnsA4Lw=
X-Received: by 2002:a81:b286:0:b0:533:9185:fc2c with SMTP id
 q128-20020a81b286000000b005339185fc2cmr9960049ywh.7.1678210762823; Tue, 07
 Mar 2023 09:39:22 -0800 (PST)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 7 Mar 2023 17:38:47 +0000
Message-ID: <CAPt2mGMgCCWYP-ZaHCovMuRZmHYYPhApNiUybKTw4pr5XwZkjw@mail.gmail.com>
Subject: v6.2 client behaviour change (repeat access calls)?
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I noticed a change in behaviour in the v6.2.x client versus v6.1.12 (and be=
low).

We have some servers that mount Netapps from different locations many
milliseconds away, and these contain apps and libs that get added to
the LD_LIBRARY_PATH and PATH on remote login.

I then noticed that when I ssh'd into a remote server that had these
mounts and the shell was starting, the first login was normal and I
observed an expected flurry of lookups,getattrs and access calls for a
grand total of only ~120 packets to the Netapp.

But when I disconnect and reconnect (ssh), now I see a flood of access
calls to the netapp for a handful of repeating filehandles which look
something like:

 2700 85.942563180 10.23.112.10 =E2=86=92 10.23.21.11  NFS 254 V3 ACCESS Ca=
ll,
FH: 0x7f36addc, [Check: RD LU MD XT DL]
 2701 85.999838796  10.23.21.11 =E2=86=92 10.23.112.10 NFS 190 V3 ACCESS Re=
ply
(Call In 2700), [Allowed: RD LU MD XT DL]
 2702 85.999970825 10.23.112.10 =E2=86=92 10.23.21.11  NFS 254 V3 ACCESS Ca=
ll,
FH: 0x7f36addc, [Check: RD LU MD XT DL]
 2703 86.055340946  10.23.21.11 =E2=86=92 10.23.112.10 NFS 190 V3 ACCESS Re=
ply
(Call In 2702), [Allowed: RD LU MD XT DL]
 2704 86.056865308 10.23.112.10 =E2=86=92 10.23.21.11  NFS 254 V3 ACCESS Ca=
ll,
FH: 0x7f36addc, [Check: RD LU MD XT DL]
 2705 86.112233415  10.23.21.11 =E2=86=92 10.23.112.10 NFS 190 V3 ACCESS Re=
ply
(Call In 2704), [Allowed: RD LU MD XT DL]

This time we total 5000+ packets for this login which becomes very
noticeable when the Netapp is 50ms away.

I didn't understand why the first login was fine but the second goes
into this repeating access pattern. I set actimeo=3D3600 (long) but it
does not seem to affect it.

I do not see this prior to v6.2 where repeated logins are equally fast
and we don't see the repeating access calls.

So a bit of digging through the v6.2 changes and this looked like the
relevant change:

commit 0eb43812c027 ("NFS: Clear the file access cache upon login=E2=80=9D)
[PATCH] NFS: Judge the file access cache's timestamp in rcu path?

I reverted those and got the prior (v6.1) performance.

What constitutes a login exactly? I also have services like "sysstat"
or pcp that cause a systemd-logind to trigger regularly on our
machines.... does that count and invalidate the cache?

Do the repeated access calls on the same handful of filehandles make
sense? Even prior to those patches (or v6.1) there are only a couple
of ACCESS calls to the Netapp on login.

We are a bit unique in that we run quite a few WAN high latency NFS
workflows so are happy to trade long lived caches (e.g. actimeo and
even nocto on occasion) for lower ops at the expense of total
correctness.

Cheers,

Daire
