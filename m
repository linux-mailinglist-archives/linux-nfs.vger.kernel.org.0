Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634332A90C7
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 08:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgKFHzh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 02:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFHzh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 02:55:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E411AC0613CF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 23:55:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x13so559600pfa.9
        for <linux-nfs@vger.kernel.org>; Thu, 05 Nov 2020 23:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vNTjVgxkPvmeBU6XigJRjVRo7PVUVZgAnnFozK8lRO0=;
        b=HhQ7o+Ayu+EWgUZSf8FQA7jTBJoafIKGT24J6hYFbOcVE5h/apuXnaDfGfz/2Vsnql
         gV/8SO5W7UTHzUZvPQnEamFfZxWS1lur1IFKMmBVuvbq1fMKUn9uSFX9OW3H36Y2fFWf
         o2qobZHeFyRr1/5QTykc8dJ7p+K2JRtCIP9UyWKbHxc6LK6kxxb8Youq0FD8RW5gPcPP
         ZznY+AzCvdGwzBeH/nmdvQwNRTcMVI5l/u711CmzIf7ECgl3swyW5j/hRyKl/jM2uuJX
         cL0yRq0gnb0mKR30TAX1GdOneje+KG8EIRGPqmQl4+NFeYOgvVWvW0bRXriJqf+odZxa
         O2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vNTjVgxkPvmeBU6XigJRjVRo7PVUVZgAnnFozK8lRO0=;
        b=UP4q3cy8P/JfLjnhCKisjL6Cecih2z1QTwtvhk3XZOFEMNoZInRIUQznGn/x1exbaZ
         TxKvMQUmPYJ4NSUQDE0m1laRk6cCtHfiojBfP/kBoKuIL4BdJODfUq/KZsUJjwOa8nwV
         0uWrkFdpmQymLfxBTO4iSryaIsBAV4Q1eg8bKD+Xg7BFe7jyfsZnpFK+sL4bFU7muRzF
         /Q82AGqc9Clv2P0CN+Dr4vmK2L7DEvqNNb9NDasPvwM1jRvXtQesjj7kowwQCG2wFBWq
         jF6O86InoIS6w6sWM5GJCFoZsQ0KE3mwGtTXYDkDTmPkJiIc2YT3F+GP1VG9dqr3tG1v
         PQLw==
X-Gm-Message-State: AOAM530N4hfUmIuQf/WlncCk1PizCXVkrX+71FwRWf8x6kDb0DjWjlQ9
        deyG/UnL9cvB/M8foBoHTEU=
X-Google-Smtp-Source: ABdhPJwGNAhUL2YqPPEdeVC0QRrNiQ07m4TkdJI3NyEzlceKWuJY02DpYv7jjiDG41uHdThMwLgXlg==
X-Received: by 2002:a62:2b88:0:b029:163:c6fb:f2a with SMTP id r130-20020a622b880000b0290163c6fb0f2amr904774pfr.7.1604649336464;
        Thu, 05 Nov 2020 23:55:36 -0800 (PST)
Received: from loghyr.internal.excfb.com (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id k8sm1044638pfh.6.2020.11.05.23.55.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 23:55:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: question about labeled NFS+rfc7569+selinux
From:   Thomas Haynes <loghyr@gmail.com>
In-Reply-To: <CAN-5tyFAc0R=D0OL2WHkKacTMW0JxKmLoqv2A2Et2gg5G6gjtQ@mail.gmail.com>
Date:   Thu, 5 Nov 2020 23:55:33 -0800
Cc:     NFSv4 <nfsv4@ietf.org>, linux-nfs <linux-nfs@vger.kernel.org>,
        earsh@netapp.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7C9450B-5782-4F1D-9F32-86D8B31820A0@gmail.com>
References: <CAN-5tyFAc0R=D0OL2WHkKacTMW0JxKmLoqv2A2Et2gg5G6gjtQ@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 5, 2020, at 11:47 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> Hi folks,
>=20
> I would like to know if somebody can comment on the following
> regarding labeled NFS.
>=20
> RFC 7569 talks about Label formats and specifically lists that "0" is
> a reserved value.
>=20
> Using labeled NFS with SElinux and looking at labels (in wireshark),
> the selinux sends sends/sets label format as 0 (ie. this is a reserved
> value according to the spec)
>=20
> So we have labelformat_spec4 set to 0 where the spec says this field
> "The LFS and the Security Label Format Selection Registry are
> described in detail in [RFC7569]". It's unlikely that  "0" reserved
> for Selinux and not explicitly specified there?
>=20
> 0 seems to be a good choice for using as a default label which the
> RFC7862 vaguely talks about (though says nothing about the format for
> a default label).
>=20
> I'm not aware if Selinux is supposed to follow a spec and therefore I
> don't think it is obligated to follow the rules of RFC 7569. Anybody
> can comment how labeled NFS label format and SElinux label format
> choice are supposed to co-exist?
>=20
> Thank you.

Hi Olga,

The SELinux implementation of Labeled NFS is not spec compliant.

There are two paths forward:

1) Fix the implementation to be spec compliant.
2) File an errata to RFC 7569 to allow 0 to be assigned to the SELinux =
implementation.

The argument against 1) is that there are existing deployments of =
servers and clients which will be incompatible.

Thanks,
Tom=20=
