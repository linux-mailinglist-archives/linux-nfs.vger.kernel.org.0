Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8A918F841
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCWPJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 11:09:24 -0400
Received: from s58.linuxpl.com ([5.9.16.239]:58478 "EHLO s58.linuxpl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgCWPJX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Mar 2020 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=belsznica.pl; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VUO4baYboHc6GjSEBBYJBRBJRSCwbfVrQir8Nn/n7YQ=; b=PZyWTHk869LyJQiDzV+iNejHYE
        EdH7a3VdIQtxNrlVOya9sRdWq7Wp9J2QpALCdEeZrsHqEQhonYMOKN+f0LKPVeJ7uRHLrTSeA5B8H
        Dxn4kJrMIHqQlpRNmKZ7zaYnDuzWgf8+FcJ8bpkbi/dajCBbkIbb5KA8e6DntZhmKPFBMJzPTGCsy
        z5rMEjQH3MZ5vmoq1no8d9ZmY4C/s1kz8MLL8wZG1vtsQ3/weqM3wPctmQts4hEELlSJrHDy90eo+
        R8SlPEvt2PFQv4qjtDSv3jv55c38kS12Q0P3lPyTW1Z6CX0TyXsjWzGQ+6RBrFTNUeWbeC44OiCcj
        r/KuJ8Kg==;
Received: from user-94-254-177-101.play-internet.pl ([94.254.177.101] helo=mordimer)
        by s58.linuxpl.com with esmtpa (Exim 4.92.3)
        (envelope-from <jasiu@belsznica.pl>)
        id 1jGOhb-0006rs-Ez; Mon, 23 Mar 2020 16:09:19 +0100
Received: from mordimer (localhost [127.0.0.1])
        by mordimer (Postfix) with ESMTP id E2A726F8DA;
        Mon, 23 Mar 2020 16:09:19 +0100 (CET)
Date:   Mon, 23 Mar 2020 16:09:19 +0100
From:   Jan Psota <jasiu@belsznica.pl>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: refcount underflow in nfsd41_destroy_cb
Message-ID: <20200323160919.021e6c8a.jasiu@belsznica.pl>
In-Reply-To: <0C8A86EA-6015-4E9E-9A0E-DAEB4E988269@oracle.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
        <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
        <20200322044352.2ff1fbd8.jasiu@belsznica.pl>
        <0C8A86EA-6015-4E9E-9A0E-DAEB4E988269@oracle.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Operating-System: Linux; Gentoo
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/YXd8sJ27OnSWy2BfF=1Pnjq"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--MP_/YXd8sJ27OnSWy2BfF=1Pnjq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I thought I read in the initial report that you were seeing this
> problem only on v5.6-rc6. What is the earliest kernel release
> where you saw refcount UaF warnings from nfsd4_destroy_cb?
> 
I didn't noticed that earlier too, because until connection breakage on
WireGuard I did not have any problems related. But when you are asking,
I found it in my Pentium G2020 system too since 5.5.4 kernel and 5.4.2
looks not affected (I have logs since 01 Jan and fault begin to appear
on Feb 21, when I switched from 5.4.2 to 5.5.4 kernel a day before)

$ journalctl | grep nfsd41_destroy_cb
lut 21 01:07:58 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
lut 27 01:01:12 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 03 00:59:01 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 03 23:03:02 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 11 11:52:42 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 13 01:12:02 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 14 14:31:39 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 15 20:56:56 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 17 15:58:32 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
mar 22 15:24:03 mordimer kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]

I attach NFS part of my .config and a screen dump of menuconfig.

--MP_/YXd8sJ27OnSWy2BfF=1Pnjq
Content-Type: application/octet-stream; name=nfs.config
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=nfs.config

Q09ORklHX05FVFdPUktfRklMRVNZU1RFTVM9eQpDT05GSUdfTkZTX0ZTPW0KIyBDT05GSUdfTkZT
X1YyIGlzIG5vdCBzZXQKQ09ORklHX05GU19WMz1tCkNPTkZJR19ORlNfVjNfQUNMPXkKQ09ORklH
X05GU19WND1tCiMgQ09ORklHX05GU19TV0FQIGlzIG5vdCBzZXQKQ09ORklHX05GU19WNF8xPXkK
Q09ORklHX05GU19WNF8yPXkKQ09ORklHX1BORlNfRklMRV9MQVlPVVQ9bQpDT05GSUdfUE5GU19C
TE9DSz1tCkNPTkZJR19QTkZTX0ZMRVhGSUxFX0xBWU9VVD1tCkNPTkZJR19ORlNfVjRfMV9JTVBM
RU1FTlRBVElPTl9JRF9ET01BSU49Imtlcm5lbC5vcmciCiMgQ09ORklHX05GU19WNF8xX01JR1JB
VElPTiBpcyBub3Qgc2V0CkNPTkZJR19ORlNfVjRfU0VDVVJJVFlfTEFCRUw9eQojIENPTkZJR19O
RlNfRlNDQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX05GU19VU0VfTEVHQUNZX0ROUyBpcyBub3Qg
c2V0CkNPTkZJR19ORlNfVVNFX0tFUk5FTF9ETlM9eQpDT05GSUdfTkZTX0RJU0FCTEVfVURQX1NV
UFBPUlQ9eQpDT05GSUdfTkZTRD1tCkNPTkZJR19ORlNEX1YyX0FDTD15CkNPTkZJR19ORlNEX1Yz
PXkKQ09ORklHX05GU0RfVjNfQUNMPXkKQ09ORklHX05GU0RfVjQ9eQpDT05GSUdfTkZTRF9QTkZT
PXkKQ09ORklHX05GU0RfQkxPQ0tMQVlPVVQ9eQpDT05GSUdfTkZTRF9TQ1NJTEFZT1VUPXkKIyBD
T05GSUdfTkZTRF9GTEVYRklMRUxBWU9VVCBpcyBub3Qgc2V0CiMgQ09ORklHX05GU0RfVjRfMl9J
TlRFUl9TU0MgaXMgbm90IHNldAojIENPTkZJR19ORlNEX1Y0X1NFQ1VSSVRZX0xBQkVMIGlzIG5v
dCBzZXQKQ09ORklHX0dSQUNFX1BFUklPRD1tCkNPTkZJR19MT0NLRD1tCkNPTkZJR19MT0NLRF9W
ND15CkNPTkZJR19ORlNfQUNMX1NVUFBPUlQ9bQpDT05GSUdfTkZTX0NPTU1PTj15CkNPTkZJR19T
VU5SUEM9bQpDT05GSUdfU1VOUlBDX0dTUz1tCkNPTkZJR19TVU5SUENfQkFDS0NIQU5ORUw9eQoj
IENPTkZJR19SUENTRUNfR1NTX0tSQjUgaXMgbm90IHNldAojIENPTkZJR19TVU5SUENfREVCVUcg
aXMgbm90IHNldAo=

--MP_/YXd8sJ27OnSWy2BfF=1Pnjq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=nfs-config.txt

=E2=94=82 =E2=94=82         --- Network File Systems                       =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         <M>   NFS client support                       =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         < >     NFS client support for NFS version 2   =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         <M>     NFS client support for NFS version 3   =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]       NFS client support for the NFSv3 ACL =
protocol extension               =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         <M>     NFS client support for NFS version 4   =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]     Provide swap over NFS support          =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]   NFS client support for NFSv4.1           =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]     NFS client support for NFSv4.2         =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         (kernel.org) NFSv4.1 Implementation ID Domain  =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]     NFSv4.1 client support for migration   =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]   Provide NFS client caching support       =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]   Use the legacy NFS DNS resolver          =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]   NFS: Disable NFS UDP protocol support    =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         <M>   NFS server support                       =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         -*-     NFS server support for NFS version 3   =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]       NFS server support for the NFSv3 ACL =
protocol extension               =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]     NFS server support for NFS version 4   =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]   NFSv4.1 server support for pNFS block lay=
outs                             =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [*]   NFSv4.1 server support for pNFS SCSI layo=
uts                              =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]   NFSv4.1 server support for pNFS Flex File=
 layouts                         =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]   NFSv4.2 inter server to server COPY      =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]   Provide Security Label support for NFSv4 =
server                           =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         < >   Secure RPC: Kerberos V mechanism         =
                                 =E2=94=82 =E2=94=82 =20
=E2=94=82 =E2=94=82         [ ]   RPC: Enable dprintk debugging            =
                                 =E2=94=82 =E2=94=82 =20

--MP_/YXd8sJ27OnSWy2BfF=1Pnjq--
