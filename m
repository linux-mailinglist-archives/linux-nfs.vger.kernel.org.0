Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA8601A94
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJQUuO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJQUuN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 16:50:13 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859D134
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 13:50:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 69D695C014E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 16:50:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 17 Oct 2022 16:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        doriantaylor.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666039809; x=1666126209; bh=tEb6gWJ0iE
        MFGEsHDNW4whMbVyNVKEgMRfX9v4wMpUI=; b=Ks1cMToNfcbb711JS62VBxCaMi
        x3hRO+NBWE9Rk6dPgn3fravXtaqUJT0LG6DFP0pFWJZJ0t0jdQKCiaCHf0kkwWrC
        Ra+HJvnyyB41bwb+sDqUO39kHkclo37CaiEIHkL4i+ccIy28hMsDSFaDvo4Ok9oN
        wPE53gwfy1WklfDUAcLzyzQsll5gibbKlXUxaLffSn/he52BcLuy4hc5CA0T/5h5
        NYnAiyL7PpFf/ETkTOsKj9a3h9l8CCAxVGg+cDfXaCBmhEB1+b8egtIquw7BW1ZC
        H7gPmDpYkzTLXT+DF38UFrzh+fGRaTTsVYpey6glb/6ZB79qg23Cvx6UFbVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666039809; x=
        1666126209; bh=tEb6gWJ0iEMFGEsHDNW4whMbVyNVKEgMRfX9v4wMpUI=; b=h
        O1D+NRXhsLnJQFQFo3mAGFCzglGuSDHejAhEZoE/l5Qq61mfOh0YR+3TeqUTANKO
        itZzvyzzhhxPZW349dmw1eBzNC0YCHq/uPFbM2Mry5vPRj/kp6RQHstz6jf8vx0W
        aSH321Pnlm37w/WvElyTPUUYmmefuScM2TPwoSQKGcka6Mo31Ju69FGktzaEe3Df
        ZUgDN9h6tEnKArqaA9BZK1PUAPgQOV9Jauq7iGBy2blwGSYV4IbsB4QtawkPnElQ
        /bZtDMnv4n9OZ/46xlBPNNny/n9wu0kOp2pcCFpZUHgfwm7GcAemlKMNO6MaSZVL
        4ggh+R1RcJDju5wDY3LWg==
X-ME-Sender: <xms:AcBNYwYrXhtPl4w8Yyypae4fvvvfKZxvkwYaBAtA4HA3Kep1CFwEvA>
    <xme:AcBNY7bRPWcdRra7PqGtDv5OMk6KLiIsgRDD88O7enMS2hDXPRa8-5zheEKzv81Zy
    IwMSY5zr14EsRis2g>
X-ME-Received: <xmr:AcBNY68m5J7g1pzi7P7CQWXowq779FZom3unx-eYLTTB2RAP17demIrZ87OxteOSDIC9gBmMmlYUWxbllrdeL4ySNtp9c3802o-nfhMHorRbUBtPS89GTxPfSsVOqQH-7aTzYrag3q90eiJ_rid2aucQ66wqepvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhtggguffkfffvofesghdtmherhhdtjeenucfhrhhomhepfdffohhrihgr
    nhcuvfgrhihlohhrucdlnfhishhtshdmfdcuoehlihhsthhsseguohhrihgrnhhtrgihlh
    horhdrtghomheqnecuggftrfgrthhtvghrnhepjeefhfegvefghfekveevffduieehuddv
    vddvvdefgeejveekleduiefgjeefkeejnecuffhomhgrihhnpehmrghrtgdrihhnfhhopd
    guohhrihgrnhhtrgihlhhorhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehlihhsthhsseguohhrihgrnhhtrgihlhhorhdrtghomh
X-ME-Proxy: <xmx:AcBNY6oeHVK2qbMYAnTpfT5ZEe_vPpGfJljGsku6P5r6gsXnmCWEqw>
    <xmx:AcBNY7qO7gyL4gZ_ijzPKeq7pAcwudRjahhXkSDr69PfLjitoW9yHg>
    <xmx:AcBNY4R9LDaQiN0-v9tu3FOO6zoHB6Embu9fwAvdaWryzHzf9DxYTg>
    <xmx:AcBNY8kGZF-TLe7ODiIJKev6Gs3A68G0GEohp0m4n0S9Zi-Q15sQ5g>
Feedback-ID: if359451d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 16:50:09 -0400 (EDT)
From:   "Dorian Taylor (Lists)" <lists@doriantaylor.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0D1EC4DB-36DF-4F31-B0F9-1ECB1B6F5C85";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: non-root user mounting NFSv4 with sec=krb5{,i,p}
Message-Id: <A82A8BFA-7B04-4F8E-93D8-9B0111DC0D1A@doriantaylor.com>
Date:   Mon, 17 Oct 2022 16:50:06 -0400
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--Apple-Mail=_0D1EC4DB-36DF-4F31-B0F9-1ECB1B6F5C85
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Greetings List,

I have been successfully using a non-root user on a Linux client to =
mount (with an appropriate fstab entry) NFSv4 using Kerberos for about a =
year now, but it only works if I do the following:

* run `rpc.gssd -n` as root
* run `kinit mynonrootuser@REALM` as root (from a login shell, not =
su/sudo)
* also run `kinit` as mynonrootuser (expected).

This "works", for some definition of the term, but I consider it to be =
limping along. Since NFS needs two tickets to authenticate, the main =
failure mode is root's ticket (for the non-root principal) predictably =
doesn't get renewed when the Kerberos infrastructure renews the ordinary =
ticket, seizing up any affected mounts. It=E2=80=99s a =
marginally-tolerable configuration for a personal laptop but altogether =
inappropriate for much else.

I tracked the problem last year down to a mismatched uid in the pipefs =
protocol (see thread =
<https://marc.info/?l=3Dlinux-nfs&m=3D164029845630159&w=3D2>). It seems =
like a simple enough bug to fix but as I mentioned in the previous =
thread, if I knew where it was happening I'd have sent a patch by now. I =
am curious if there has been any attempt to fix this in the last year.

Regards,

--
Dorian Taylor
Make things. Make sense.
https://doriantaylor.com


--Apple-Mail=_0D1EC4DB-36DF-4F31-B0F9-1ECB1B6F5C85
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCibkUxMA9OSsNh/irFKO32Nr6MFAmNNv/4ACgkQirFKO32N
r6NT1hAAmQcip8sLC8yDYFdvb9b6dgol2rRLNZv0D6ufPTaEFihQhZZXM6ExLlSW
5OO5hlyB4OPksMJWt1VW5oK3lV1IEUudPeo4imCNv8gJPOoQVgk5K8HTeIxurg+i
dH+8i5l24XPbzpwoUQQr538AqBzr2a0R6OneX6OdT8+L814nCLnOVZzIYq64MCuv
JDd6vdE5gVMecILSCO8K6soLNuLUvRBf1YmF6VFdjNnVeEWhLApKLx4+Mj6sl997
/cnnN8jFGMi5J+cHseMo2JueJVq1+lDAvXicSGnF3a11iQvDQ0x7yIJmtYVot4WG
02Av3UwremcLyn81O0JlNF/PTwue1zJG0lfLHUr+61Vlto1roCW5ITQTqyTDDmF1
fc6gb43JTElZHzCsgQcJdPH/CXSp9/N/HMOhKgBdF4IUVrPTbPXVMQ1t94LHAi3/
ytvh4YLtLET5kJ0ee+o52aTmccEOfkNYCdVM3tL0JT0EeIap8PRafJ4euhuDOiJ7
lVbq11lzvCvc92hGATk5euEXbHlv87BHKwQsqKa0L6RdMMlXrzfjKDMNodOwasq2
IZGO4+Gwhor2hjNX4KNhGdEE9eMuFczU1nZkrjfsi0Pw9p68jkB+b5Z52E0pwTDJ
70qh17Mn1MJA/mi5AdPXX5wZvBMN1awUjBR9UZgXhkrf/YHmYz4=
=7s88
-----END PGP SIGNATURE-----

--Apple-Mail=_0D1EC4DB-36DF-4F31-B0F9-1ECB1B6F5C85--
