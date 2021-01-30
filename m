Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1076309763
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Jan 2021 18:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhA3Rqs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Jan 2021 12:46:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38962 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhA3Rqr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 Jan 2021 12:46:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UHhdSq143784;
        Sat, 30 Jan 2021 17:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=a3FqtYlwfQj+pNEp/s5pNoD9j54ktpk8eeSn4ePCroE=;
 b=UevHrABXH49c4sVYmOU7xpWxJEZceBVCVRwk7tKRPlM8MIQt5SgAxsXTOSSw6nsVur/f
 b6wdcLNks6XPGNVdoIMDudckqtrYd5ndffhV0ZB2Hzon8YFrK7qpN2/0tO+k3tvlbCT4
 nHKew/qqGlWUqhdazxY+G01YTdWrlQykGTQR4CI/AcR8UZuEmgyV2EKN6eXXQvxI3JuC
 DpBi5sEe+vxGcyYnOAnseUUN05E2vMSXSuAJ5BxCADq7dFALO6yCxhz6Gv5cHOxPbqhT
 TXCUH6w2dKRcAEVmlughOYDPVeTwPWZQcSFx+Q+9OEkjzJuJ9SInzwHMnP785EgisZ9f VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyah6sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 17:45:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UHfINi074457;
        Sat, 30 Jan 2021 17:45:58 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by aserp3030.oracle.com with ESMTP id 36cwg9u9c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 17:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2ex5+0GNicQfRFJ8rUu0wgTjuTeiF34jaqb3vMnneQ+D/UuTxYGUmoDGmNUjIbYzvV+vyBemsI8G8psVJb6UwTYtKyhC7rCuwKkonDSXM7uXVPL8YxoHGGhaTxplaiEuHs/mxrZGbzU9tmomKj5BVTL8Xr1OJbgoBqmI+OhsEruyBTNt66LDAd2ph7MuAGODlvTO5zYYjsikNJ6pW26SU/5kwGKRivLmWAKCrvNXrJM0lf2SV6RP6HgFtQCSoXJUcw+rK7ARNgke9f1d0tMEbYNEb4TG98V8BRRTUV9IK7Yfh0EejM/KA26Ez3ydxPofXYFvoJN3CPb9zSwJ3K6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3FqtYlwfQj+pNEp/s5pNoD9j54ktpk8eeSn4ePCroE=;
 b=KIRUO9xbcvXBJIhxbrVb3GFEQYImuQgP53CC51BzDVwYVpI7jEITHkvYWSWBUPminkKR7O2iTIp0EULzN73Odxiul3xfo0jdOVCCUnjAPwc4yg9HPZ1Ots982a3r1Anl3P18mJ90+8/yuLD/wvZBLB1/rUBEuCig9lkexLZSTsmHaoqyoAJba53LNy1frHbu5pAZQBFw+i/Vp2BX94ZBtA3F2uIHvoWN9X0i63TagT+q/zrcB19wY4tHxkTYtRcLngdlfy3Ev618Wex2W2nB5BC7PCmJHOdYFKoypzqui6BbNV/IwzZlX3Z+e89QzUT/ivtwPPtsdx/cOMHINo8SVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3FqtYlwfQj+pNEp/s5pNoD9j54ktpk8eeSn4ePCroE=;
 b=rLs+Jp76Dt/Xn/SqapNtA63xgSMr7rO3f3bt9UNpIq2H9GTNj9Cf4MA3exQjzEQ/l0AwOm8CYyZs16Q9rLD9SnXIiaC/mzmjl7X7fj+anwiPNjBEUJTz3On6NbROLgx1Li8HskG0DuUxQGyX9QCIYasv74pYnRS1ov3+mTjhi6U=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3778.namprd10.prod.outlook.com (2603:10b6:a03:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Sat, 30 Jan
 2021 17:45:55 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 17:45:55 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "A. Duvnjak" <avian@extremenerds.net>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd issues in 5.10.11
Thread-Topic: nfsd issues in 5.10.11
Thread-Index: AQHW9k69KquWRfbK30WUoKO4pr//HKo+wTAAgAEcogCAAJUUAA==
Date:   Sat, 30 Jan 2021 17:45:55 +0000
Message-ID: <92F1D388-52EC-4464-80FB-DBF9DDFB08F0@oracle.com>
References: <68D3109F-82A1-43BF-AA45-6E1C532D3BC4@extremenerds.net>
 <D7596D40-F549-4299-AC50-D81F6692FA13@oracle.com>
 <E154BD9D-3FA0-4EC0-B5A2-BA9DC88D9A4B@extremenerds.net>
In-Reply-To: <E154BD9D-3FA0-4EC0-B5A2-BA9DC88D9A4B@extremenerds.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: extremenerds.net; dkim=none (message not signed)
 header.d=none;extremenerds.net; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efaafd31-023c-4551-4eba-08d8c546e528
x-ms-traffictypediagnostic: BY5PR10MB3778:
x-microsoft-antispam-prvs: <BY5PR10MB3778473A2C24D64AE3027DEC93B89@BY5PR10MB3778.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39Y/iV2/U1ldLoh86Pob8YYoIz+inpnrFy15+5dNMd9XmjI0RnNt5Go/9g+CvQDiWU9Dlk8JGTdib52+s7/8Fwcngiu9F4Q1iieqAvBDd11RM3D8w8Ix8eyQPSEgO+wchWKtoBYE9oxVhdw+rQZ/i5TM0QGd7p2qiV8YZPRkxdBGZnXsq8Zc1eQI1LgegCDdDqQOhsdSLu1kIEDr0xDxg+Z2DXWrtlAGt2IGi3M6MJ8NvCCQHtS+uSHukxLtOl0xxAleVwbLdyPLfEWLT5F9eVdKv+ktJqFuFX0K2PCM4Ajea8hgvcqyyCCwuctBU9Yn9ceB54mMtWaKDLwF/OQC7wXnh3bbeRH+rXDCwo+qISuHI9QJMH+LXfKedni+zNJUxH9TBL9l/yNDNyc67uXL8va4uUGbNzifx5uDjd0hZ/u+ma1jFWu6LyBlvyhVxdW1MXIeJ5hgTTK8wD92h128cQOcPN89PGHh2wFnYUudNpk7vGZuYE4m4RyIVymeoqUBHZcJH9hNPVYRsmxA8TMZn4iJrdSlqd6SPeDm7RFk+OHPW5kdK1VAINaz+fuweiokwhqrLDI9KrfFFqwGeDw+Dwkk+v5o0ZBh421Tm8Z4jqXkTvJ4EsEHXM+dW9wkA1oh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(86362001)(76116006)(6916009)(64756008)(2616005)(66476007)(66946007)(7116003)(91956017)(4326008)(26005)(478600001)(66556008)(8676002)(316002)(6486002)(186003)(66446008)(44832011)(966005)(8936002)(6512007)(5660300002)(53546011)(6506007)(71200400001)(36756003)(83380400001)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?k6mPoHASYEUAMJajbDwaVTh4Br9nujCBw8rWw1CSAplLQTlC8QpduloCVFS2?=
 =?us-ascii?Q?VrqefjPmXgwJMrWhmI9+JNQz86y1UMp99P4QXRhtI33rLkhhmDgSEWvQiMMP?=
 =?us-ascii?Q?UT7uol+bqIaH76QCbqLCG9huNTZjHJTrMA4rCI2913waP0c4HB+D9uHZjCWx?=
 =?us-ascii?Q?7yz/Ml2RrY0xbzIsr6mi3SJ4aiP+92dftH+QAjUTPzcdrjpQbKicotgmN09h?=
 =?us-ascii?Q?1439c9Ek0QdB4GNCnMrvIsDA48ih1g7VBbjpAps8J5+4P56V9yOZ/RONeWkd?=
 =?us-ascii?Q?7khDtBrtjp9R+VRvbPDb8HPS7tu5q/ZIrp0XhwwhMjvw47QrEN2LjmzL8bEw?=
 =?us-ascii?Q?lbQxO0cmVfxq+9sy+lmP/O/Gr3IsjFt7du7KmttOM6kEKHohuSEtfTc+xECF?=
 =?us-ascii?Q?SrLFw8h2ghaTuXENaao1OnErTf6LYiaVAwJs/9ZIt6m1fiqBmmFR82m0WkrG?=
 =?us-ascii?Q?S56xJvwzNr22iByh6DUsJM96guiYD5uiJwC3OwYQbrIRDhSQYj+9L9zwb0fs?=
 =?us-ascii?Q?J0nEgXDSMB1AGbVX2F3wkRoTybADa8o6wY+2Mnr7oLpZYLKzDRKyYDjzf7+g?=
 =?us-ascii?Q?f7Pq3nqjrSP0D4mwQU0LMiYtySDLKc65FyhASBmEFV6O1bmJunF1JvP5066K?=
 =?us-ascii?Q?KfFWYUg+dUVRLNhd4GMl/WWegz135jxKr7ecOLkopTr1xasRHAAQlLdry1DM?=
 =?us-ascii?Q?n035s23BtLVK0SraN9FPkl+FaAcHN48W62YAjGtoer1FpWnBexK5JYVskqBu?=
 =?us-ascii?Q?Z/GNeheyBbzCaxJEofZfExhh5wfCQN620XhkCmfc1Ao8PjSbmwLObwTi4IRK?=
 =?us-ascii?Q?m5prm3lJA8Rix8t98IPUEPY9SUUhRJKEvGQ1ikIE52lI6BNoGw0O+zNHpEwh?=
 =?us-ascii?Q?hYds1QCrUAZ4GvcTw5RLLB+G9wLbaqDNRPoTsby0fnYAKdfWKxGfbdXb88OV?=
 =?us-ascii?Q?1burMX5q+SZcpaw5GA8aGHytHzCoAKNlbSqhO80lcwsN9P0C1HdhzVu23Vaf?=
 =?us-ascii?Q?iUBJZ7inGsDUeoMGXTVQ66Qe+mrwz1gtmHkeXHzJPRjYgBsUhPfhNMFGl/tM?=
 =?us-ascii?Q?R+yt+zdULq5x6vz4SLpnU/gTprjkEQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <542AD15CA997794B9F49963BE73F1698@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaafd31-023c-4551-4eba-08d8c546e528
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2021 17:45:55.4806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aOqzNuFlfdTnKa6acc+XFqFEZuf5mc8zzPLKpqJr2pmFTeM0v38lLnn8Sc2lm+qvprdgRgSWoRoK8ZUUisEtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3778
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=969
 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300098
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300098
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 30, 2021, at 3:52 AM, A. Duvnjak <avian@extremenerds.net> wrote:
>=20
> Thanks Chuck,
>=20
>     I have some tcp dumps for you, some are too large to send via email e=
ven when compressed (i.e. approx 100M).  Funnily enough I found a folder th=
at I couldnt browse at all in Kodi (it will just crash when entering it), s=
o I have a dump of both the attempt at browsing the folder (obviously with =
5.10.11), and browsing the folder successfully (with 5.10.11).
>=20
> kodi_folder_freaks.bin   (2.3M)

The client RST's its connections in frames 223 and 224 just after a
successful NFS READ. There's no indication in the wire capture about
why.


> kodi_folder_works.bin   (25M)
>=20
> Below are tcp dumps of Kodi streaming approx 15 seconds of video footage.=
  First is with 5.10.11 where it is struggling to play.  Second is playing =
successfully with 5.10.10.
>=20
> kodi_struggling.bin   (110M)

I see some duplicate TCP Acks, which suggests the problem might be at
the network layer and not in the NFS server.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ONC-RPC Service Response Times - kodi_struggling.pcap:
Index  Procedure  Calls  Min SRT (s)  Max SRT (s)  Avg SRT (s)  Sum SRT (s)
---------------------------------------------------------------------------
NFS Version 3
ACCESS         4      1     0.000119     0.000119     0.000119     0.000119
GETATTR        1      6     0.000059     0.000139     0.000122     0.000734
LOOKUP         3     24     0.000057     0.000201     0.000125     0.002999
READ           6    112     0.000087     0.014444     0.007711     0.863614
NFS Version 3
---------------------------------------------------------------------------

I don't see any READ errors.

Avg READ RTT is 7 milliseconds, Max is 14 milliseconds. The server seems
to be responsive.


> https://deathbytelevision.com/kodi_works.bin    (98M)

Even more duplicate Acks here.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ONC-RPC Service Response Times - kodi_works.pcap:
Index  Procedure  Calls  Min SRT (s)  Max SRT (s)  Avg SRT (s)  Sum SRT (s)
---------------------------------------------------------------------------
NFS Version 3
ACCESS         4      1     0.000073     0.000073     0.000073     0.000073
FSINFO        19      1     0.004495     0.004495     0.004495     0.004495
GETATTR        1      7     0.000063     0.004627     0.000769     0.005386
LOOKUP         3     28     0.000031     0.008314     0.000389     0.010904
NULL           0      1     0.000103     0.000103     0.000103     0.000103
READ           6     98     0.001370     0.084851     0.010576     1.036461
READDIRPLUS   17      1     0.014783     0.014783     0.014783     0.014783
NFS Version 3
---------------------------------------------------------------------------

Avg READ RTT is 10 milliseconds, Max is 85 milliseconds. The server is
responsive, but /slower/ in this case.

I don't see anything obviously wrong at the NFS level in the "struggling"
or "freaking" cases. At this point my advice is:

- Reach out to kodi.tv to see if they can provide any insight or diagnostic
tips to help us drill into this further.

- If you know how to do a git bisect, you could bisect your server kernel
between v5.10.10 and v5.10.11, looking for the place where Kodi starts
to complain. There are some TCP changes in there that could be relevant.


--
Chuck Lever



