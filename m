Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF1BF6A2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfIZQZq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 12:25:46 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:41624 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfIZQZp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Sep 2019 12:25:45 -0400
Received: by mail-yw1-f50.google.com with SMTP id 129so923396ywb.8
        for <linux-nfs@vger.kernel.org>; Thu, 26 Sep 2019 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=FV1fVpoM7/5s55NMPUgj83aREaCcSAUuQsL5txL0eC8=;
        b=qquBpn2ToOb/tb6GORZxtUyiB++qYapkVkY1uKf7Z1y2wTpQbyyzLahTmeNOUoAsAq
         j9ggn4+QgVanmH2FH6zNx6sQPhZXVbcqlSmHnCurPDZql4wKOBAdMpbGjbV0gJd3Az0Z
         wLNIkteWuzZH5Ragp3Wgkd29dwvsN9tudplNENfCavCyaiw/BHSrctRrjlg2rwFyNR5B
         xm0AL0NNdy0UsJ4wfK9pgvYNCZqm9DiDuGIZHNyo4O+IozcyyLioNOYO38bKMigH2pK6
         P8KiS1nJ2tusF5WyqtdlPGcu7z9hxC5OmpK0YlMUdkD0UeWPmQJHXFVA2J3NJBlBuTwq
         gpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=FV1fVpoM7/5s55NMPUgj83aREaCcSAUuQsL5txL0eC8=;
        b=I0rgVfSyGTwVINREm7mAMfKjfClfhpZfMgyNG1B08CQorPkN+fsRfhqmh/Nks8nqGq
         4oCKduxUphv9Uei6WPkxNX+ioZDaDlu4U4xj+kkOy5sK90pKjQ/lTDlzkto+CNBPEUzl
         1k6vG3dDPB3qoPI1CroptnShn3SY80jBJSeeRzIeR3mi1+aJiB2tUvLNgv+Ce2F1E2T6
         MU1Rhy8NsAFlK7VxHi9abMa7l+CF6yUq1LCBuRi0+FV45tCL0Et6vD2PIzd9RWHxMs4n
         d1kXzw9+jDXntSWEr1M98uj46YLECLZgPGdKVklQIQDgZSa6FdJ2ijneSC2Pyn4+LV2r
         BYfw==
X-Gm-Message-State: APjAAAXsARgBHN29gwNINsMdbycxlnnyIl0S+lyhNCwQxDWkFPVu9kOx
        ovtEtFLogkMKc0zEw0Ka0LSQrque
X-Google-Smtp-Source: APXvYqwwcOa0EqbjcUoVqBwq1iBZ2CxbwvQd7nIuxc8NBrdswt1cz3pIW6mUFyrSHil84JuEfSXD4w==
X-Received: by 2002:a81:7a15:: with SMTP id v21mr3246534ywc.238.1569515144639;
        Thu, 26 Sep 2019 09:25:44 -0700 (PDT)
Received: from ?IPv6:2600:1005:b10e:c343:38f8:2541:7d45:d4bd? ([2600:1005:b10e:c343:38f8:2541:7d45:d4bd])
        by smtp.gmail.com with ESMTPSA id d123sm576418ywb.11.2019.09.26.09.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 09:25:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Kevin Vasko <kvasko@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Thu, 26 Sep 2019 11:25:42 -0500
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Message-Id: <3260B7EA-2B89-4EA2-BCFE-833C63EF0441@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: iPhone Mail (17A577)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce,

Yes. It=E2=80=99s a Dell EMC Unity 300 storage appliance.=20

=46rom what I have gathered, under the hood it is running SLES12SP1

3.12.74-60.64.66.1.NEOKERNEL_SLES12SP1 #2 SMP Fri May 17 06;41:36 EDT 2019 x=
86_64

Unfortunately I only have limited access to the appliance through a =E2=80=9C=
service=E2=80=9D account. I do not have root privileges and I can only run c=
ertain commands under the service account.=20

I=E2=80=99ve got a ticket open with them and it=E2=80=99s been escalated to t=
heir =E2=80=9Cengineering=E2=80=9D department but they haven=E2=80=99t provi=
ded much insight as of yet.

If you give me some idea on what might help I=E2=80=99ll try to get more inf=
o if I can.


-Kevin

> On Sep 26, 2019, at 11:06 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> =EF=BB=BFOn Thu, Sep 26, 2019 at 08:55:17AM -0700, Chuck Lever wrote:
>>>> On Sep 25, 2019, at 1:07 PM, Bruce Fields <bfields@fieldses.org> wrote:=

>>>=20
>>> On Wed, Sep 25, 2019 at 11:49:14AM -0700, Chuck Lever wrote:
>>>> Sounds like the NFS server is dropping the connection. With
>>>> GSS enabled, that's usually a sign that the GSS window has
>>>> overflowed.
>>>=20
>>> Would that show up in the rpc statistics on the client somehow?
>>=20
>> More likely on the server. The client just sees a disconnect
>> without any explanation attached.
>=20
> So watching a count of disconnects might at least tell us something?
>=20
>> gss_verify_header is where the checking is done on the server.
>> Disappointingly, I see some dprintk's in there, but no static
>> trace events.
>=20
> Kevin, was this a Linux server?
>=20
> --b.
>=20
>>> In that case--I seem to remember there's a way to configure the size of
>>> the client's slot table, maybe lowering that (decreasing the number of
>>> rpc's allowed to be outstanding at a time) would work around the
>>> problem.
>>=20
>>> Should the client be doing something different to avoid or recover from
>>> overflows of the gss window?
>>=20
>> The client attempts to meter the request stream so that it stays
>> within the bounds of the GSS sequence number window. The stream
>> of requests is typically unordered coming out of the transmit
>> queue.
>>=20
>> There is some new code (since maybe v5.0?) that handles the
>> metering: gss_xmit_need_reencode().
