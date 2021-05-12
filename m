Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3533237BE63
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhELNmG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhELNmF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 May 2021 09:42:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F839C061574
        for <linux-nfs@vger.kernel.org>; Wed, 12 May 2021 06:40:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so35073680ejc.4
        for <linux-nfs@vger.kernel.org>; Wed, 12 May 2021 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p04CLBCyL3eVWEfy3ys/wh6hSJH2B+RoaWI4w2wmS5A=;
        b=tnTCmphopyc0kUklS8Ycn4NP6Z/tD/S9oT4y5bY1dktsA2vkV91TS50Xp5VPdH3Rx9
         Zu6QJEyHOejC0MxRtGtPqqiETqChfvtaeXtDJR6RmtfnS1eyZbFj+EMW/6QvjRayq/hQ
         Lna51vILHPalvdCbjCkgMQzacSQi5ZYX1Kxa5AyFWzEXiYbdkRBK2OE7x3K/QKPyVnUc
         1QboYYrWRRqycsp22NtXuufhyjg9kgtucKAsn0BNMNLUKeYMGkfuXonMWDYhHFi3dpfw
         mmXeCnMBBpMnNtATdCgwOuOkKEyDkYqBLNaYPnwWHfjada37tG/89cuKO4Yx0+Wcp4Fj
         jGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p04CLBCyL3eVWEfy3ys/wh6hSJH2B+RoaWI4w2wmS5A=;
        b=Q11huKFl0MCc7JQcUW/oYZBec0lDBBBwV2gqtsHI/P4toM+07uOegtlAAwD8jFmolX
         rCwQtyyzvxBanShz464Oql6JeKybPD21ZRRTQqphJkVZxXBLkkWk6a3/qcXYaeh5rtef
         0T20O2PtzM9lKnb7OmYC2sRsrMytlmH9rKQRcV6BhiMSZJHD98jH5ck00S+J34VOtOWW
         CepjlS6+856UQpilzGeGCzQsKxSWfzGp6g5zcPrwrHaleSEnnyHFApAmdKfvC7rrSNI3
         Tjie1X6oBRaZgsT0Y2me0Qff3nT7mh++sgfdkprc2RQBSkNkC1Rq5QKPSvmXQDydRjVG
         zC9Q==
X-Gm-Message-State: AOAM533rackwC6XXuEYtkjkE/44rptbhSkbZV3iA+SwKmXF0d6zAc1pK
        5wKe7rIgPiy9a/nFq2KIdjhs1mEIDQu7/czwQLEsl03nn9w=
X-Google-Smtp-Source: ABdhPJw4TXxqb+flYBihYUElivxSauv9c84MiX8xqTN7s6G2cOgH+z+YNfop+60bWAueE/S0UFU2Xje0/S8fIUFW0ZY=
X-Received: by 2002:a17:906:d159:: with SMTP id br25mr10423676ejb.248.1620826855258;
 Wed, 12 May 2021 06:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com> <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
 <20210512104205.hblxgfiagbod6pis@gmail.com> <CAN-5tyEoaKseyjOLA+ni7rCXG7=MnDKPCC3YN68=SHm9NaC_4A@mail.gmail.com>
In-Reply-To: <CAN-5tyEoaKseyjOLA+ni7rCXG7=MnDKPCC3YN68=SHm9NaC_4A@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 12 May 2021 09:40:44 -0400
Message-ID: <CAN-5tyHy8VR4apVCH0kFgmvceWynx5ZwngdT3_V6abDXZnmDgg@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
To:     Dan Aloni <dan@kernelim.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 12, 2021 at 9:37 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
>
>
> On Wed, May 12, 2021 at 6:42 AM Dan Aloni <dan@kernelim.com> wrote:
>>
>> On Tue, Apr 27, 2021 at 08:12:53AM -0400, Olga Kornievskaia wrote:
>> > On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <dan@kernelim.com> wrote:
>> > >
>> > > On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga Kornievskaia wrote:
>> > > > From: Olga Kornievskaia <kolga@netapp.com>
>> > > >
>> > > > An rpc client uses a transport switch and one ore more transports
>> > > > associated with that switch. Since transports are shared among
>> > > > rpc clients, create a symlink into the xprt_switch directory
>> > > > instead of duplicating entries under each rpc client.
>> > > >
>> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>> > > >
>> > > >..
>> > > > @@ -188,6 +204,11 @@ void rpc_sysfs_client_destroy(struct rpc_clnt=
 *clnt)
>> > > >       struct rpc_sysfs_client *rpc_client =3D clnt->cl_sysfs;
>> > > >
>> > > >       if (rpc_client) {
>> > > > +             char name[23];
>> > > > +
>> > > > +             snprintf(name, sizeof(name), "switch-%d",
>> > > > +                      rpc_client->xprt_switch->xps_id);
>> > > > +             sysfs_remove_link(&rpc_client->kobject, name);
>> > >
>> > > Hi Olga,
>> > >
>> > > If a client can use a single switch, shouldn't the name of the symli=
nk
>> > > be just "switch"? This is to be consistent with other symlinks in
>> > > `sysfs` such as the ones in block layer, for example in my
>> > > `/sys/block/sda`:
>> > >
>> > >     bdi -> ../../../../../../../../../../../virtual/bdi/8:0
>> > >     device -> ../../../5:0:0:0
>> >
>> > I think the client is written so that in the future it might have more
>> > than one switch?
>>
>> I wonder what would be the use for that, as a switch is already collecti=
on of
>> xprts. Which would determine the switch to use per a new task IO?
>
>
> I thought the switch is a collection of xprts of the same type. And if yo=
u wanted to have an RDMA connection and a TCP connection to the same server=
, then it would be stored under different switches? For instance we round-r=
obin thru the transports but I don't see why we would be doing so between a=
 TCP and an RDMA transport. But I see how a client can totally switch from =
an TCP based transport to an RDMA one (or a set of transports and round-rob=
in among that set). But perhaps I'm wrong in how I'm thinking about xprt_sw=
itch and multipathing.

<looks like my reply bounced so trying to resend>
