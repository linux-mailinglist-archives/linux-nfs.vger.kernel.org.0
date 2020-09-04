Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6281625CF8B
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIDDBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Sep 2020 23:01:20 -0400
Received: from mail-bn8nam12on2105.outbound.protection.outlook.com ([40.107.237.105]:45893
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729036AbgIDDBT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Sep 2020 23:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzYZoQAVHOhi1Kd3LsdKZvl1Bp4R5ZB5Vrdvrwj5eeyVilOktd1QP/wbuSLLD22t6DkeyIt6RSGOE5piZ68DNoLYD6T9Jz9QQo7S8lHG6GKQnQ4eecDObSHzBCaNEH6LeOT3a/u6IfmrK+wKeXf40j2IBEm4ZmIt4r7eBLQffMWW7dbMuw+pl44G5YISMQprBw1TssIDwoLZCWrYhLaBp9fRCngB/e0rugwjrMNKrXAUW3mjuNlE+mOor2STOnAMYDdweUb3AvXX/GU74uAyujLgVYQtmc/4rz3TchlAti2PzjEFQ2vPgNn1Umr+QYyAe8taCt3QasUZ8dx0CXF+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXXWq/BqX8ICJKzs6K/qjttG2OLcbBJ5zg4ldLt/6fA=;
 b=Vls5vbAfItypNjwG28NvlsUlIBAEqJPenIwnpV7Mo+FuIUu6nqiBH87fBA9Ejvq+GVdc/4cTSFMmQH5tBq7F8CQb4kbXChMkcB0iQaKNf8edD4aGEizlzbdo+dnuPIpnM43bEu7wBzZ795AtXrc2ZIJOFtCuVgD+8Si00Z8A7nZ/T8jLRk+FTsCWsMP7fafwfSlbKOA88xO2l4emcf8EclEasiyHmGIrqLFQxETaYjvK/6PcGWYQn08c8pwyf0XtoyBu4Fl/DdkLM7A4+F+LVxjgaFrzIywD2GfI74PrUAcCHVatWeGeiXQtB7GT+repEJdnEMNLOr/6kjCcAG1H0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXXWq/BqX8ICJKzs6K/qjttG2OLcbBJ5zg4ldLt/6fA=;
 b=IuRPF2t3G+90zjTMoc97hOVUSpeySXRdNZr3j1psFXyW60aMFzW5fx4N7CpoL7XSXUe7rkaU9mKw1dG+6tYEequKw+WUGdxf0k7GOxInxczR/TMdA55MH+di56/uYRVovdsAyVuKToweTY0bJ6WZ4r75X8jE8Y4qGLlv5kFRaO0=
Received: from MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10)
 by MW2PR2101MB1788.namprd21.prod.outlook.com (2603:10b6:302:b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.0; Fri, 4 Sep
 2020 03:01:14 +0000
Received: from MW2PR2101MB1019.namprd21.prod.outlook.com
 ([fe80::5c6d:4846:8bdf:3354]) by MW2PR2101MB1019.namprd21.prod.outlook.com
 ([fe80::5c6d:4846:8bdf:3354%3]) with mapi id 15.20.3370.001; Fri, 4 Sep 2020
 03:01:14 +0000
From:   Steven French <Steven.French@microsoft.com>
To:     Chuck Lever <chucklever@gmail.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: RE: [EXTERNAL] Re: [nfsv4] NFS over QUIC
Thread-Topic: [EXTERNAL] Re: [nfsv4] NFS over QUIC
Thread-Index: AQHWgky2NJrQQmalbkOZx7rNKhrK9alXoTMAgAAFx4CAAB/l0A==
Date:   Fri, 4 Sep 2020 03:01:14 +0000
Message-ID: <MW2PR2101MB1019BE158E3F96ED36AEF37EE42D0@MW2PR2101MB1019.namprd21.prod.outlook.com>
References: <20200903215242.GA4788@fieldses.org>
 <EFDBAD41-E0BE-4AEF-8E37-18A414CE8588@gmail.com>
 <20200904003242.GB4788@fieldses.org>
 <064FD529-9526-4F34-BBE9-E9CDAC2EED5D@gmail.com>
In-Reply-To: <064FD529-9526-4F34-BBE9-E9CDAC2EED5D@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=80a9e646-ba6e-4a26-9e49-5b7e91d4a344;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-04T02:47:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2605:6000:101c:207:d127:2325:6e3:215a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83a4b99c-64a8-4554-670d-08d8507ec957
x-ms-traffictypediagnostic: MW2PR2101MB1788:
x-microsoft-antispam-prvs: <MW2PR2101MB178832DE661A5524B3BD1C12E42D0@MW2PR2101MB1788.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lCeJNmSgwsTdwqa0L/mqSBc7O3WmdeY1Q+0IMy4mDJs5bYFuWogpTifUdLTpr5Z56GoA/tcCEYIJg+ESzytWFGUucuIBpF9gv7Z5LbtwryAd99sd7nzdlgREVSCjTQ69sLOU+ESYtVwikk8Et8uBEY+fB3XvNHEkyi9huy1BgXry8zvLlSG37oNjidRtPi/29Fmiu7ePsUhjOdqth3SnvpU7DOD2+bODMMlsRTtEqBE6182cCP01xSTWvOsA1fUHWnsbG7FydSGLazppNzFduxgJanptebcPVU2M6HZF+yDY7YycSyfrNkIucFjFtjVvvq7/lGkpja3djqOGiPeBkrxIX3o1ZKusu+CHaVrMi7x1fhlHUwi9Wjk+hGxrpiapi4bb6ddkTuG0ZIbDTQsR5WJbWohX6BDARyc/PzfLjmGn206PV0gyc3PA4KOl74+E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1019.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(66574015)(54906003)(4326008)(66446008)(83380400001)(64756008)(71200400001)(33656002)(9686003)(86362001)(66476007)(8990500004)(76116006)(8936002)(66946007)(478600001)(55016002)(8676002)(110136005)(966005)(2906002)(316002)(66556008)(82950400001)(52536014)(83080400001)(6506007)(82960400001)(186003)(7696005)(5660300002)(10290500003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Halwfn0vR3I+MoNzggWCPEhXRxSys/qSaUnTICWNMB4INI8lR3BaFI27mfJ/QRqgEY932egcM2SZaMvwWBfOl99NRVRr4weiNJiAgX9ievc3900VGF2v0VlS3fAZpMTocrjUoWfxdNAnqeRT1fiu/7zfZms6cLirr+lCizm52mjUUqR9wFno9Hl/52hU5u7ssh5Duo5YUPpvmbixVn5r+KJmNUjxQb1pko65TcBZyl+w3WeznocZ12mdphsHSGnlu2WKuxMa7StozvfyGHtZzdDxnztfl36VmibEhwVFGWzZsojvpZmRTsCk46tFjUDQt1HRhqntOqPYuiYr9JJNEOLcV2HmkU5pb67D0IQxFu1y04dVNOgKBB2zllCPsZDu7fmS6KpZQfPQJnOBBBvvHO/exG9AK7ssMpB89LfLbrO4IE2AHQOamDauZ56woxU0Kf6o8IUHs+uH2idr5fINEvk+RnFiKZEvCQKQCa3WbYQXZZRAG8y9OF5bVRpH5Xd2oHPcUt6L+M/6IUIZFbP3dITpWqZLUWN/o4nqXmSliO5A3Zk6wlSEMmRBZkpSWNdli1brC2A7KZ8+SlyWiE0EeXOIZf67Eg0qH44gXCXd4eRcnXqswHrBRL7T+hhwrL8YbZj8qKyoiNGow7M/4N+FB7QDzH9ZZjuWfqx2PrNr2Y9zLcfCyzPuvvSc/wvIkjmDdgKQcobOuvw5vd+YIAd7aA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1019.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a4b99c-64a8-4554-670d-08d8507ec957
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 03:01:14.5755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZdfP5eq3WsY6ECQV5eUp71qz6/C2NhOQZA7LZ/1aiSMEzzIojj9h9Gwq1BFmOuq0wK9YG3bnUb/CCQnSvsDOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1788
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We (open source SMB3 developers) have been thinking a lot about SMB3.1.1 ov=
er QUIC especially after the interesting talks on this at the last few SDC =
conferences e.g.

https://www.snia.org/sites/default/files/SDC/2019/presentations/SMB/Li_Fran=
k_Surfing_the_World_Wide_File_SMB3_Improvements_for_Safe_and_Efficient_Inte=
rnet_Access.pdf (slides 8 and following).

And some of the broader coverage:
https://redmondmag.com/articles/2020/03/02/microsoft-smb-over-quic-to-windo=
ws.aspx

I have gotten a chance to talk with some of the developers of the recently =
open sourced quic libraries (https://github.com/microsoft/msquic) and there=
 are various code style issues that would prevent it being merged into Linu=
x kernel without significant changes (not just to fix camelCase) but ... it=
 is a very very promising place to start.

One of the ideas being bounced around is to do this in stages - first try t=
o cleanup the kernel style issues with the open sourced msquic project and =
merge it experimentally into the Linux client (cifs.ko) since there should =
be SMB3.1.1. servers to test it against reasonably soon (presumably we will=
 know a lot more after the 2020 SNIA SDC talk on SMB3.1.1 over QUIC in a fe=
w weeks updating us on status https://www.snia.org/events/storage-developer=
/2020/abstracts#smb-Dantuluri) after we are convinced that the quic driver =
interoperates ok then move it into the Linux networking stack and let the n=
etworking experts clean it up more and remove the 'experimental' tag from i=
t when satisfied.

More discussion is needed on this so we should add samba-technical and some=
 of the network experts as well.

I am very excited about the possibilities opened up by a decent quic kernel=
 driver, but the current cross platform open sourced driver is fairly large=
 - ~90KLOC so will have to be trimmed down (and a lot of boring changes to =
convert to kernel style needed).

-----Original Message-----
From: Chuck Lever <chucklever@gmail.com>=20
Sent: Thursday, September 3, 2020 7:53 PM
To: Bruce Fields <bfields@fieldses.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; NFSv4 <nfsv4@ietf.o=
rg>; Steven French <Steven.French@microsoft.com>
Subject: [EXTERNAL] Re: [nfsv4] NFS over QUIC



> On Sep 3, 2020, at 8:32 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Thu, Sep 03, 2020 at 07:48:19PM -0400, Chuck Lever wrote:
>> Hi Bruce-
>>=20
>>> On Sep 3, 2020, at 5:52 PM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>>>=20
>>> I've been thinking about what might be required for NFS to run over=20
>>> QUIC.
>>>=20
>>> Also cc'ing Steve French in case he's thought about this for CIFS/SMB.
>>>=20
>>> I don't have real plans.  For Linux, I don't even know if there's a=20
>>> kernel QUIC implementation planned yet.
>>>=20
>>> QUIC uses TLS so we'd probably steal some stuff from the NFS/TLS draft:
>>>=20
>>> =09
>>> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fda
>>> tatracker.ietf.org%2Fdoc%2Fdraft-cel-nfsv4-rpc-tls%2F&amp;data=3D02%7C
>>> 01%7CSteven.French%40microsoft.com%7C9bab515f15bc49fbbe2c08d8506cee6
>>> 3%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637347776075883604&am
>>> p;sdata=3DpOnlPJcTkyJiqQm%2BCbo7dbOAqHMKFIi01qrShVZTH%2Bk%3D&amp;reser
>>> ved=3D0
>>=20
>> The link to the latest version of that document is
>>=20
>> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdat
>> atracker.ietf.org%2Fdoc%2Fdraft-ietf-nfsv4-rpc-tls%2F&amp;data=3D02%7C0
>> 1%7CSteven.French%40microsoft.com%7C9bab515f15bc49fbbe2c08d8506cee63%
>> 7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637347776075883604&amp;s
>> data=3DYYBPryN5sFJApWm%2BkQvmjYzGXxjxI1fXRUWVXvVGE24%3D&amp;reserved=3D0
>>=20
>>> For example, section 4.3, which explains how to authenticate on top=20
>>> of an already-encrypted session, should also apply to QUIC.
>>=20
>> Most of the document's content will be re-used for defining=20
>> RPC-over-QUIC, for example the ALPN defined in Section 8.2.
>> Lars Eggert, a chair of the QUIC WG, has been helping guide the=20
>> RPC-over-TLS effort with an eye towards using QUIC for RPC when QUIC=20
>> becomes more mature.
>>=20
>> I thought the plan was to write a specification of RPC-over- QUIC as=20
>> a new RPC transport type with a netid and uaddr along with a=20
>> definition of the transport semantics (a la TI-RPC).
>> The document would need to explain record marking, peer=20
>> authentication, how to use multi-path and multi-stream support, and=20
>> so on.
>>=20
>> Making NFS work on that transport should then be straightforward=20
>> enough that perhaps additional standards work wouldn't be necessary.
>=20
> Oh, OK, good.  Sounds like you're way ahead of me, then, I didn't know=20
> there was a plan.

That's all there is for the moment! :-)


> --b.
>=20
>>> QUIC runs over UDP, so I think all that would be required to=20
>>> negotiate support would be to attempt a QUIC connection to port 2049.
>>>=20
>>> The "Transport Layers" section in the NFS RFCs:
>>>=20
>>> =09
>>> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fto
>>> ols.ietf.org%2Fhtml%2Frfc5661%23section-2.9&amp;data=3D02%7C01%7CSteve
>>> n.French%40microsoft.com%7C9bab515f15bc49fbbe2c08d8506cee63%7C72f988
>>> bf86f141af91ab2d7cd011db47%7C1%7C0%7C637347776075893604&amp;sdata=3Dej
>>> gN6OuHrcDMzejeEKbaP5UiD1GAxHfQcPyLZZ45vbo%3D&amp;reserved=3D0
>>>=20
>>> requires transports support reliable and in-order transmission,=20
>>> forbids clients from retrying a request unless a connection is lost,=20
>>> and forbids servers from dropping a request without closing a=20
>>> connection.  I'm still vague on how those requirements interact with=20
>>> QUIC's connection management and 0-RTT reconnection.
>>>=20
>>> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
>>> w.ietf.org%2Fid%2Fdraft-ietf-quic-applicability-07.txt&amp;data=3D02%7
>>> C01%7CSteven.French%40microsoft.com%7C9bab515f15bc49fbbe2c08d8506cee
>>> 63%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637347776075893604&amp;=
sdata=3DTZeoR%2FT22hg%2BkG0LllDEttlgdzv%2FAsH8PeXbdEHQ9Mk%3D&amp;reserved=
=3D0 looks useful, as a guide for applications running over QUIC.  It warns=
 that connections can time out fairly quickly.  For timely callbacks over N=
FS sessions, that means we need the client to ping the server regularly.
>>> Sounds like that's what they do for HTTP/QUIC to make server push=20
>>> notifications work:
>>>=20
>>> =09
>>> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fto
>>> ols.ietf.org%2Fhtml%2Fdraft-ietf-quic-http-09%23section-5&amp;data=3D0
>>> 2%7C01%7CSteven.French%40microsoft.com%7C9bab515f15bc49fbbe2c08d8506
>>> cee63%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63734777607589360
>>> 4&amp;sdata=3DrF91Tq8OXHeN7W5iuSbtYotq1XBC4Zc8DGEGzwPUuTg%3D&amp;reser
>>> ved=3D0
>>>=20
>>> 	HTTP clients are expected to use QUIC PING frames to keep
>>> 	connections open.  Servers SHOULD NOT use PING frames to keep a
>>> 	connection open.  A client SHOULD NOT use PING frames for this
>>> 	purpose unless there are responses outstanding for requests or
>>> 	server pushes.
>>>=20
>>> QUIC allows multiple streams per connection--I wonder how we might=20
>>> use that.  RFC 5661 justifies the requirement for an ordered transport =
with:
>>>=20
>>> 	Ordered delivery simplifies detection of transmit errors, and
>>> 	simplifies the sending of arbitrary sized requests and responses
>>> 	via the record marking protocol.
>>>=20
>>> So as long as we don't try to split a single RPC among streams, I=20
>>> think we're OK.  Would a stream per session slot be reasonable?  I'm=20
>>> not sure what the cost of a stream is.
>>>=20
>>> Do we need to add a new universal address type so the protocol can=20
>>> specify QUIC endpoints when necessary?  (For server-to-server-copy,=20
>>> pnfs file layouts, fs_locations, etc.)  All QUIC needs is an IP=20
>>> address and maybe a port, so maybe the existing UDP/TCP addresses are e=
nough?
>>=20
>> --
>> Chuck Lever
>> chucklever@gmail.com

--
Chuck Lever
chucklever@gmail.com



