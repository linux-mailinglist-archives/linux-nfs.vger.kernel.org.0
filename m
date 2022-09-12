Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871155B5CA4
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiILOtV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiILOtU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 10:49:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791BE2F02B
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 07:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D260B80CAA
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894ECC433D6;
        Mon, 12 Sep 2022 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662994156;
        bh=PDYXkMlNN1pYxk9SGE2NU9/RQvbmOuzKSx1YCy4yt0o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=L18rIJaMJLexdOGj5DpKtYHN/H8XpbjL/exkmaiM0XBm1+udRyO31V2/aIQIzbRWk
         5popbK5oY9qLth7pAkkaI90L4mH/OiAvjtRMFdx7RbUZ30OjwlbEqs+Cw7yX3Ppezh
         0WX0EeSvNyr7ESA7SPNLb7v5vhcUW1w98Rcth9s5Vy+t18WfGz9+7Y0upHKnSnifeT
         vLV0PEOV821hAhVRqOncgqZcu8M11o2UXdnOCazH4qOMWC+VWg6ieiBn7JkiklpWqt
         AwoEwrBgvjf+g+XoIaKZ9Fl7Yq7tQpWiEVSBkH0XSN9BuqzRgr42aKQ5NrOGb+BNic
         1iNHwqsspfZNg==
Message-ID: <26398d6ee1b5a8d69a1c17cc30f5363a0da5650a.camel@kernel.org>
Subject: Re: [nfsv4] Announcing the Fall 2022 Bakeathon
From:   Jeff Layton <jlayton@kernel.org>
To:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Date:   Mon, 12 Sep 2022 10:49:15 -0400
In-Reply-To: <c0d059fc-a41c-ca24-59f8-ad7f780f91f0@redhat.com>
References: <480ddad3-f93a-dab3-0f50-b4b7ebacd6e9@redhat.com>
         <c0d059fc-a41c-ca24-59f8-ad7f780f91f0@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm planning to attend in-person this year.
-- Jeff

On Wed, 2022-08-31 at 16:32 -0400, Steve Dickson wrote:
> Hello,
>=20
> Just a quick reminder... The Bakeathonn is a
> little over a month out... I know a lot of the
> Red Haters planning on intending F2F...
>=20
> I sounds like Netapp plan on being there in person as
> well as virtual. I have heard rumors that Oracle
> plan on attending F2F.
>=20
> Still looking to hear from HammerSpace, Amazon,
> Google, Vmware, CEA and HP. I'm hoping they
> will be attending... one way or another.
>=20
> I would like to set up talks Tue, Wed and
> Thur at 2pm EST. So you are interested in
> hearing about something or if you want to
> talk about something or just status on
> things (RDMA, TLS, QUIC, Session Trunking)
> Just let me know. I'll set up a google
> doc to sign up....
>=20
> I'm pretty sure I will be able to set things up so
> the remote  people can participate.
>=20
> As usual, Red Hat will be having a few
> "pops" with hors d'oeuvres starting
> around 4ish each day...
>=20
> steved.
>=20
>=20
> On 7/13/22 10:59 AM, Steve Dickson wrote:
> > Hello,
> >=20
> > Red Hat is pleased to announce that we'll be hosting the
> > Fall 2022 Bakeathon at our Westford office in Massachusetts, US.
> >=20
> > The event will be F2F as well as virtual. Hoping to
> > draw as many participants as possible.
> >=20
> > Date: Mon Oct 10 to Fri Oct 14
> > Address: Red Hat, 314 Littleton Rd, Westford, MA
> >=20
> > Details, registration and hotel info are here [1].
> > Any questions please send them to bakeathon-contact@googlegroups.com
> >=20
> > I hope to see you there... One way or the other!
> >=20
> > steved.
> >=20
> > [1] http://www.nfsv4bat.org/Events/2022/Oct/BAT/index.html
> >=20
>=20
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4

--=20
Jeff Layton <jlayton@kernel.org>
