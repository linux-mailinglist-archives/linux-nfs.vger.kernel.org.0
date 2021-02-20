Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BF32070B
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Feb 2021 21:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBTURk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 20 Feb 2021 15:17:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34558 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBTURj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 20 Feb 2021 15:17:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11KKGUS8186022;
        Sat, 20 Feb 2021 20:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vrrLM1TBSvF0qqK20t5CM7ce4uJZHPuPwv3/B6Dmz5c=;
 b=pjLe7VKQDuOv6RWYcMvO2GWwFVfch+T6VCJion5GoBofxARa2AHxUHUFgL/fvcKJcsoK
 wt4Enioplxg9DUbOtJYJWQ3EpeW3aSNRftUFAgPi2wvhBWYumg+uKOv0inE7nzhsIyhO
 vONlYvYitk1J65zUEYlXVJbOOx/awU1UkroP/qm70nOeHTDDpX0ph6NHkGZ7B1UMfTA4
 e/hmyM8kLvd+t6nX5ajospcfNC3ypYrmHs/NWqZ7e1z2eFajzwjK9qw/mTIK56hpXVhT
 hMVefA8gXINolcATcCKkjf2FJe4U/XjA+Ef8YceUzpoi5QrAwowB5XEFEIrvHvtDi7wu yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36tu2n0t84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 20:16:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11KKGTJe021580;
        Sat, 20 Feb 2021 20:16:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 36tt80pps8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 20:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvwwXTQq/sL2CUi88ncpBSbiuHX087ahnjaeaRnLOQyPKhZ1GbwNpkEjClXk0Uv0qdSDMJMlXAZ8pfcivlcElugA6SWIiycOoiFJloR9+ehCH/8llLvHMtI97acQFLMst57mm7jD/WCX/1z+wyDpMz5EK+Rf7V3X2bY+9ClJE5rxoE8M14ckB5pPFw7ICzotPePs0Yfqp4mL7U2XlWjL2msh8oK9octj7FGnGdkO7PaGqjLzh0kHJlVUsIdzS1/0kNL6yvh3nOV4Kr8n+GFWIEjOtvFyn5wVdZF7gHaKWOTPMQ6kzJ1wxITv6o8wMsvA0ObbdpV1e3s6ZQGBCw7nKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrrLM1TBSvF0qqK20t5CM7ce4uJZHPuPwv3/B6Dmz5c=;
 b=dOoLMFdlaNAL/6blR0rxYA137IKWzN9TtDh+5L6UL5/WYNQe3/hlVqcABDidI7jVN4T2Xyv9cm/hoRLgU7/ukdw8aC6vQUH57GfzJIVhwLU2BWw6RyzsiNzQCwSPvIoi16tUwcCTO9rCM7MO1qHSyJqclOC3RfhhIFIxbddeDXBLdMEB0uQEDYgdVvqGO3t7csbS1sJkdVm+qKbPURhLOEJi7Pw0qupT8okA+XumNuV86MMSV/8bBWGTkrnqwNG9HD0Fw3u/sX1wCwDczwb1sc22U75g4jQAN5oqplXgH6igFzW7w8IbyzBy/JBEL3Csx89uAOrxWqchs7kUChBYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrrLM1TBSvF0qqK20t5CM7ce4uJZHPuPwv3/B6Dmz5c=;
 b=VrlQi1kCjjjE9/EVlHiNW9V4bxK4jUzrXtanp/NI+TaCkZzHZemqXEWx+r9Xe4/FpZxIa9ZzHlMJQCH39zP6JRtuSdX0eowzhGRx/AyTbEVk8XdBxbPUXuKvAkUm0LuObixM5OVLuapkjitGPO8AoUvRXmRW1X0sMwsU/OPR5/c=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Sat, 20 Feb
 2021 20:16:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3868.031; Sat, 20 Feb 2021
 20:16:27 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC:     Salvatore Bonaccorso <carnil@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "940821@bugs.debian.org" <940821@bugs.debian.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: NFS Caching broken in 4.19.37
Thread-Topic: NFS Caching broken in 4.19.37
Thread-Index: AQHXB8OUt1bYm8JlxU2kOK1wOnml66phej8AgAAAwQA=
Date:   Sat, 20 Feb 2021 20:16:26 +0000
Message-ID: <BEBA9809-373A-4172-B4AD-E19D82E56DB1@oracle.com>
References: <5022bdc4-9f3e-9756-cbca-ada37f88ecc7@cambridgegreys.com>
 <YDFrN0rZAJBbouly@eldamar.lan>
 <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
In-Reply-To: <af5cebbd-74c9-9345-9fe8-253fb96033f6@cambridgegreys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cambridgegreys.com; dkim=none (message not signed)
 header.d=none;cambridgegreys.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a960cf5c-4a63-454c-3770-08d8d5dc670e
x-ms-traffictypediagnostic: SJ0PR10MB4624:
x-microsoft-antispam-prvs: <SJ0PR10MB462439B27081B2ACDE8BF5EE93839@SJ0PR10MB4624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEWYqEc143qvSXSZKZR2/xqi6yHePq00dlxYEz0AHU0/SAds0nOq5/jl2B/Hf2vdMocz+XL4aNRtjUk9abHfDR7gVP7o9wdTY+3RLeNSr+T60cWPujg1Hbm6+8M7gKrbmv6laJ0PmSrBbC/z8hVy4f0j/YeC/2ZJQIEMiYL4bCTYncGPKpMon9Vh82QivXS6xhrfT8YQkYv2fUWfw3OCDx3G2YprzUXcl8kdX/c4/nFp4pIpN6+YjZAejVhGQAjIkctwkTf/Gjgdw4yiRJT5iiPPqcM/SMmLqOABOcb70h2f7BgiPUlPkY+eGDTgZs85m+3e8RjqEsVj959zCnKIp2xR4bbxa0f44boFMkkblQZojB8ENPZRapEnSegaQ3WhJJeKEpMiqRIwxZcxEG9XQyTO3gI1INLLhFBN2inxeK5X64izpCEpTrQ9jW7hi1H62U81+6KAAJ24EqgxV79L3ONBw+g6P6hQhVw6BDXHt9KOk1p81R8u52vI2qvc1rK290lyay1JaCU9/JnPBkKE/mZyO8tRrohbva3gP5z2jSlvSByZUEI3KLbVYGkYbxuXARkIRKluGp3BmlziQP1Lc+IovBeR7zFQXJgACw8YFqlJSnBBK/1oEiRPfdPdu2HIcmV1wM3hMkwBhJgwJ9SGPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(396003)(376002)(6512007)(2906002)(33656002)(4326008)(36756003)(2616005)(71200400001)(66556008)(64756008)(44832011)(6486002)(186003)(53546011)(316002)(6506007)(478600001)(26005)(66946007)(76116006)(91956017)(966005)(54906003)(5660300002)(8676002)(8936002)(6916009)(86362001)(83380400001)(66446008)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kbSxB23nKx9pd7rs8JDpx2Tib7+mDAJZ7MUlFR9kfHdcKPDowUt3ELjuYGQX?=
 =?us-ascii?Q?Xrrv12gC73ke1ZNm2WwkQpCfbanBYUvGbeDx6hxG1Ol8H/NUIN258Zz60cJM?=
 =?us-ascii?Q?pWhWM5WrcjDOaltv0+B5Oo28VwUQc1ciyt2mpeCC4g9UgN0JS0hVbB9x1g5d?=
 =?us-ascii?Q?lPgz+IXdxP9fJK3uKq7gGSmNWEiRIc7nGGSJIxBgo83sYl84ywqqvM2VQgMM?=
 =?us-ascii?Q?SmDNYvmIUCZH2aDzxTeDLe2vXVeowJoRnIzY+aUczvp0B6onS9ylExFJxlML?=
 =?us-ascii?Q?tt6Tq8fW30GROkdTxzsbJsBfGfXPQR0YcD3Ry5wKZgGRYgmOA+odjdO0hsbx?=
 =?us-ascii?Q?Stx+lOyu5KOMb0nLWRFavssR2UGyKKctDENlzHFRCCHxFXtypDAJ14Q61sKk?=
 =?us-ascii?Q?NNwqajt3pXNjexiV65qvRTpXGkCwZjZTCv/HXADVfxzxtgdfhaT0AIMsv+1e?=
 =?us-ascii?Q?ajpBevoYfgwg9VXQEInUdbxCIZudTh+GYnod/ulm77Y7VSsAnmHXnb3sNO4R?=
 =?us-ascii?Q?WuIVg9Uf6NAjfaXILI80hjnJ62l3Cfs6tiakNhAygk3Y7jbmkdkazmLjRmJ4?=
 =?us-ascii?Q?IcL9djriQrZKceRuUGUfL9GB3+GbXLPRiAxH9QQTqkETs2L4zptdGcJFKOvl?=
 =?us-ascii?Q?s0RmgE77eH/bPDFpgx5/Z/MMNKObRTPe9N59L+twc3MlSVeUGcwS6tC/3FWC?=
 =?us-ascii?Q?ekpMwPtRpFFLrphmnGj0O+qRuX9OXrYRYBE68ljfzdHoOg+gf5FPhrpEpgHq?=
 =?us-ascii?Q?rK6VbNAqcc/cqMY/QU+SvCec4peW+JTqo3UvRDUPBKfCw3s28tFFWg+dydNA?=
 =?us-ascii?Q?Q0pPRWM2f/Ys7Wr0z2VWBfN/DJXozqzXvYpzNbHNiUKAyAc/zS7yMiAkYaMz?=
 =?us-ascii?Q?ewIi/BmoG9toTCPvJm31DKpn01VK0ZIliJ3Z9TF2KN3hmEYnmTorlFkPD5O9?=
 =?us-ascii?Q?+PDBP2IdwgFNvHPjjWk6Kxjb5Xi8SWYwmLHaIa3dlu4DegojtvPHVLxOeAOK?=
 =?us-ascii?Q?yVaY+IPKwAiorBo0NYx3QKQTza/32y36L8gsBG6+iwNCM7YTZwfVGtoToQm5?=
 =?us-ascii?Q?RHIsSo8BNuOnYaFgk5RjvJU/xRiy/M39dQRUMWd31zNQYLfnvtVx4jWMeq9d?=
 =?us-ascii?Q?wP1yv0R4fTDuacHqY6MLi4LxgU2LoZzFUJJ4vabms5fpLpMRj/EHu+wXR0xz?=
 =?us-ascii?Q?6kOR5b6q6BsZ4aw6BIG3XCs6OA1tQdVieZqE+4ja4t5t9Oq76Kj4vzQBBnBU?=
 =?us-ascii?Q?d4IV969qMixvIVm69Oaz1ec1uD2SITpus/4edwZ946x5W5Hfpfc878+c9Gx3?=
 =?us-ascii?Q?tjC3rza0xYKZuFAXkOfnV5od?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46D9364746425442B756E50465B0736E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a960cf5c-4a63-454c-3770-08d8d5dc670e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 20:16:26.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YwYwFQhSU5xuq5KMLzt41QA6wSMHmW7lX2RQ0Ys7+PqQz+t87cCtjC0n9gM/1SbDJOUDv925Jjy4i8x+uvEynQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9901 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200188
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9901 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200188
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 20, 2021, at 3:13 PM, Anton Ivanov <anton.ivanov@cambridgegreys.co=
m> wrote:
>=20
> On 20/02/2021 20:04, Salvatore Bonaccorso wrote:
>> Hi,
>>=20
>> On Mon, Jul 08, 2019 at 07:19:54PM +0100, Anton Ivanov wrote:
>>> Hi list,
>>>=20
>>> NFS caching appears broken in 4.19.37.
>>>=20
>>> The more cores/threads the easier to reproduce. Tested with identical
>>> results on Ryzen 1600 and 1600X.
>>>=20
>>> 1. Mount an openwrt build tree over NFS v4
>>> 2. Run make -j `cat /proc/cpuinfo | grep vendor | wc -l` ; make clean i=
n a
>>> loop
>>> 3. Result after 3-4 iterations:
>>>=20
>>> State on the client
>>>=20
>>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/l=
inux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>>=20
>>> total 8
>>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>>=20
>>> State as seen on the server (mounted via nfs from localhost):
>>>=20
>>> ls -laF /var/autofs/local/src/openwrt/build_dir/target-mips_24kc_musl/l=
inux-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>> total 12
>>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
>>>=20
>>> Actual state on the filesystem:
>>>=20
>>> ls -laF /exports/work/src/openwrt/build_dir/target-mips_24kc_musl/linux=
-ar71xx_tiny/linux-4.14.125/arch/mips/include/generated/uapi/asm
>>> total 12
>>> drwxr-xr-x 2 anivanov anivanov 4096 Jul  8 11:40 ./
>>> drwxr-xr-x 3 anivanov anivanov 4096 Jul  8 11:40 ../
>>> -rw-r--r-- 1 anivanov anivanov   32 Jul  8 11:40 ipcbuf.h
>>>=20
>>> So the client has quite clearly lost the plot. Telling it to drop cache=
s and
>>> re-reading the directory shows the file present.
>>>=20
>>> It is possible to reproduce this using a linux kernel tree too, just ta=
kes
>>> much more iterations - 10+ at least.
>>>=20
>>> Both client and server run 4.19.37 from Debian buster. This is filed as
>>> debian bug 931500. I originally thought it to be autofs related, but IM=
HO it
>>> is actually something fundamentally broken in nfs caching resulting in =
cache
>>> corruption.
>> According to the reporter downstream in Debian, at
>> https://bugs.debian.org/940821#26 thi seem still reproducible with
>> more recent kernels than the initial reported. Is there anything Anton
>> can provide to try to track down the issue?
>>=20
>> Anton, can you reproduce with current stable series?
>=20
> 100% reproducible with any kernel from 4.9 to 5.4, stable or backports. I=
t may exist in earlier versions, but I do not have a machine with anything =
before 4.9 to test at present.

Confirming you are varying client-side kernels. Should the Linux
NFS client maintainers be Cc'd?


> From 1-2 make clean && make  cycles to one afternoon depending on the num=
ber of machine cores. More cores/threads the faster it does it.
>=20
> I tried playing with protocol minor versions, caching options, etc - it i=
s still reproducible for any nfs4 settings as long as there is client side =
caching of metadata.
>=20
> A.
>=20
>>=20
>> Regards,
>> Salvatore
>>=20
>=20
> --=20
> Anton R. Ivanov
> Cambridgegreys Limited. Registered in England. Company Number 10273661
> https://www.cambridgegreys.com/

--
Chuck Lever



