Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97E42AD7E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 21:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhJLTxV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 15:53:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4884 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232145AbhJLTxU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 15:53:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CIt8U0013002;
        Tue, 12 Oct 2021 19:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=i6v9Ej0eWLaVo6FEh/PplpDCtY0DOx2sCCuUtX24fxQ=;
 b=RUmGXf5agkoRW2RYCMFcHc/SuD+hVn78v+pYAKZq4LILQzthnpjQchM4V8fi404XTgEY
 4AaGInWIBfhsvEDjOXTmq26SjJdGB92RvBb69YJCUUpiPCrPNKmsN2OGk33h84bTF4LN
 iIy/L6bJalYK6UE5TLxEaCqAMkZ/947YHD9Wqu5sN4hP5IKSMqSzW8RM5TZUKc5CX3Fc
 mjZYLWqzLQ3WiB6qK8HGHY78Pzcrdkh6/U0zAHJksVpnNbSluxZPNOTYKuHFIFXAXNED
 9OUED58u1WBezLo9f0dF6dTWlqY79Gvm5BV10K164tPc5CmOTL63NSzcNC/bQN5I5jHL Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmpwnaxau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 19:51:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19CJUj1C165900;
        Tue, 12 Oct 2021 19:51:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3bmadykken-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 19:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+AokngGs/XASRSmiKwUXDKMmrH0jo4RVvKcL8HG3/Sjh8+z29ksga8zp+BVOsu5dcX2sTjhnQnI5E+El96GJzMZNKpdvJ0fB03dSZfPSFqCrZbbgsnhQ2XavQ81x1A43XvFD1SbRGAAdsolujnvSm0trcyiWfYM9O0hqE3i8OY/c6QkLi0zkDP1fDolFY95Z8i1tc9xvCj5qnkidK8E05k8XOYJafwra0eLV8jbJkuJ/glhoMjrjI844fPvue6sPvezwzwf10cOzOdMtp5te9rY3PV5whz1TvPHv2YKESHgWaAOiJ3m4PM4Hj8Hd7BXH/0DAlNorWo9Gps5RPZOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6v9Ej0eWLaVo6FEh/PplpDCtY0DOx2sCCuUtX24fxQ=;
 b=WaeQHDwsTKbusk8DMYW1Dvx/CY2wl1Uv2wJglIoePJgSLjjK/BR+Imjg4jpDbeOsiW5jcFV0T1o8KYDZqjbdTFv69gTpqT45RqfuMV8Ekmhzc/l1njSlIOwXEkBEKsk5YqAx21ylFRh1v1G33YYiGU85SD2QKzmGhFiJRhW3KzGX1LjPyM3bmJ5+gonbV0r9ZcbEWs6YKKkQ0LvZ29vNcYSHucLExWbMaN6uC+GmR1YL4XfMjdTp+2xVXlWreuAlBzGQs4UTXHs8FyOF1zGDRl0zyhleFClQgmygDCDDR4nNakScVavtR54L8PQeyHr1sb9peCkbVkYHgHIQdwsF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6v9Ej0eWLaVo6FEh/PplpDCtY0DOx2sCCuUtX24fxQ=;
 b=tjQXHOiOYT8tPepdeT9TgaL2c/m+bkFoyb2APVXeAxwRTAoperqVanq5D+2/rWW02RNuQj9Re2MuS5HIWk1Xh9FHN6/JLepev0J92rKQlslpzXCMKHBu5csNn/7VqldJrU/1+5wtr92GjJUb00mU7xXnCg8oHjrvGGxQEffAIg4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3336.namprd10.prod.outlook.com (2603:10b6:a03:158::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 19:51:06 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 19:51:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jussi Kansanen <jussi.kansanen@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: Stalling NFS reads with "SUNRPC: refresh rq_pages using a bulk
 page allocator"
Thread-Topic: Stalling NFS reads with "SUNRPC: refresh rq_pages using a bulk
 page allocator"
Thread-Index: AQHXv6GUiRTAl1usmkOu17sllY5vJqvPxbiA
Date:   Tue, 12 Oct 2021 19:51:06 +0000
Message-ID: <0F6DEA40-409C-46B6-917D-1C588E0D0B8C@oracle.com>
References: <2a9bdb23-e10d-1586-7b14-ca32af1939f5@gmail.com>
In-Reply-To: <2a9bdb23-e10d-1586-7b14-ca32af1939f5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d7e4222-5921-4e64-aa35-08d98db9a14f
x-ms-traffictypediagnostic: BYAPR10MB3336:
x-microsoft-antispam-prvs: <BYAPR10MB333624F0DA0DB08AAAFA4CD093B69@BYAPR10MB3336.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: br/tUOdZOmMXMos9o18PJpAFA2T7CabjneyammD+pCwW/ZQhvc2SrTlo9DgKtGAjO+CBKcNTmWhVK7PExKgGYl0wrl3U9X8lnQH1RowalrwnylGMl5moCBEhlbAYe7PQvVMNy6XxqYF1QbPQPF6GFND7je2zIiPX6w2zzGyC1J6vOqRJNEcYIDHYa5Bu0mbT1VRzpmQBjh8ctsudAGJh1FSd+iN+p5ots/T5ShaQIsDKgRrVSnV9bTTPou7LtH1bZaBenBCZhTC2/Whjnq8F52tLYXob6zT8e8PjQeZjN4yjT3FoRujpqJk2BrbdM4wjk+db7ohJYvSKEr9snc86pp29bWXnuJmkWw/d+8yhwAOXN/HLHpzfe9ldRDlmhBVaF3a9b0F8rDn4Y+vNmtdW1t9DGXFRwN/u+pdzUcin1h2VIYCv6Lxmyyay8R2OapQJhfSO6/MJ7HO2/R/lJIqvX7m571cDmjuEG4jmcQrsaRHJXTJlHL54jXs4FTQfXAppwCOpAylp73DC51xQoLpzaSPzuT5zb0wI2sQV1oCyeQJTZedJ1jdJNKDeOnDaroxtpC4slT3O/Opmr6Z6zdB/e16tlkVjWT5dpy2Uf7RE72iDkftluPKAOLg/NKnSYJEdVOMYYgl0qC0tE2acqdhVfgpXLww4+T0Vek6w7irS3qGCC3jCKdJRykyXxnRWh7UY/8y768m8icagDRAIo1hhMR1Sdu+H+l5W0cdCkSrY10s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(71200400001)(2616005)(6916009)(38100700002)(508600001)(53546011)(186003)(6506007)(6486002)(26005)(38070700005)(64756008)(91956017)(66946007)(66556008)(76116006)(66476007)(66446008)(5660300002)(2906002)(86362001)(316002)(8676002)(8936002)(6512007)(36756003)(33656002)(4326008)(83380400001)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jYenJYkrsiY71UAcUv0H58TSyiku3JDWa74FJZqPIUswSzOEOy+y0jyaCv2C?=
 =?us-ascii?Q?r9p4zYugqwvzLx9vJWqA7hn+/WQoC6aBx6SfFO24R/IkV0e2Qrh/UGpkFnia?=
 =?us-ascii?Q?NiBAv1ZKEPVc7tX+Nqf2N/Fr6LKlP+jv7lkcvzbGymU8tAkwub/oyAxxwFfO?=
 =?us-ascii?Q?rYC/RINAoWe/Ti/3G8JiY92jTYpqv3KZZ/LVLZVwnVMI8jfnwSnZL5TIyPn7?=
 =?us-ascii?Q?bVjAG7HIpE7nsawVCoOFF96lYJMDOPv9E5gN7TThjJaXWUIUPLb+3W2lCiC+?=
 =?us-ascii?Q?ZW2w4Izhc0RAP9o4iFX/g4FkxG0GyIvCMsj1tAn9Uc2/5EKHhS4nl46TLouD?=
 =?us-ascii?Q?F2Xx1+o5NoFfTXynTQCt1Ngc1Y8V1Rd2kDf3wI85k4AdwqcwZr+3RSoqHDfZ?=
 =?us-ascii?Q?fyfb4W/LNYQjy5xvb+y4Jl98bhkfHuVo1DtvlsqFf/16lG6uJ1Bfs5BpaMro?=
 =?us-ascii?Q?1M4LRkjQsrFTUAEqX83sMGj0p+rA4LPT3/b2DgFfynzKYFcpuKgSL54cs4/M?=
 =?us-ascii?Q?oQcY3NxGRnL+Lmm66F4VVcgJaJBrbE2Ppsq+8sT1OfuAfyGJNwk7Lr1g+xDS?=
 =?us-ascii?Q?UD5FY2pT7yQHmsgshp98bJLZhyCC6Lv0emN/ynuve4DtFtmgnSNiGXzijweJ?=
 =?us-ascii?Q?wD/fOJq1q/Qqj/S2Ln2peqIk3cSa/pNzaQv0vl68HAt72EsgFEZKc5Y4hcZj?=
 =?us-ascii?Q?Kw6YVT8Yr9nv4uvCHV63rcRRjY3eg+qlOrT/84WmH/OZIzy1yeXbF6Enh2ti?=
 =?us-ascii?Q?gnOHTl0/supAtN3Q/zUqpd0pkNKAfOpANGQkZGK+f0UiH99NaRyPt24PcFtq?=
 =?us-ascii?Q?TegyQAAC9IBBkwdSh57MbN/JWG8xT5y+7Qc36DhBGp1DWzud8yjbe6wNRrf+?=
 =?us-ascii?Q?fOaE06UTuB28UdXLOAc1o/RaVy9gTqJBvm8IjGH8WZRozJguGPHyUaA2Lqgz?=
 =?us-ascii?Q?5cn77MNHkwilmufsURbGuAyr0nKjN4siUIQK/351qX6hTsm8WQ8CrcglHc2b?=
 =?us-ascii?Q?rMKX6by6Y6ZAGrqH/1LxiojkxEzt3VfnRvk0sIU/lOwbAr9Jpl85BZSe+vWd?=
 =?us-ascii?Q?uELmRhw+xxzG6ceRdvoj80ScgAD2N9bosafK+nQ9SKdmlT2XcIRjerlIW2vX?=
 =?us-ascii?Q?I+BTZD0rN8BHz8tctu9OnZSD4Uqw/LpLuiUr0IfE5ISled3Mg/Ob6YpuEW7i?=
 =?us-ascii?Q?Bzm5UjgMZo9kmn3JhXEM/2f8thXXxayrPLywiUuKr/zZxgxsoceruZJgPm7p?=
 =?us-ascii?Q?Q0d76L5vOp5HwusY38xJ8Tu7gGZ9VbeD5EzvDmV07/46wNCfeFVxGzOhS0A7?=
 =?us-ascii?Q?yIGHAEXx+Oapr1vUAHzrYSez?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2E6079466DEFE4897956BC5CE4EB8D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7e4222-5921-4e64-aa35-08d98db9a14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 19:51:06.3339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +LRh8YOChzr2LnPKtSjrqtNPpqw0sfiWrIEH/2vVXvkXAc24MA3JV6vB9OS4gFfoxyeU/VTbI8qbD9Cj7TnFsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3336
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120104
X-Proofpoint-GUID: eTSr8N3p8Qw7143nKc9w-Vv8dswk9S8M
X-Proofpoint-ORIG-GUID: eTSr8N3p8Qw7143nKc9w-Vv8dswk9S8M
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 12, 2021, at 3:44 PM, Jussi Kansanen <jussi.kansanen@gmail.com> wr=
ote:
>=20
> Hello,
>=20
> I started to get stalling NFS reads after upgrading to 5.13 kernel (from =
5.12) and the issue still persist in 5.14. Bisection lead to commit f6e70aa=
b9dfe0c2f79cf7dbcb1e80fa71dc60b09, reverting it from 5.13.19 seems to solve=
 the issue.

Hello Jussi-

There have been several recent fixes in this area. Try v5.14.11.


> The problem is as follows, and seems to be reproducible:
>=20
> - Boot up system.
>=20
> - Run "tar cf - /nfsshare/somelargedir | pv > /dev/null" or just any sequ=
ential read on a large enough file.
>=20
> - Stalls start to happen usually after 2-32GB is read, though sometimes i=
t can take up to 200GB of reads.
>=20
> When stalling starts the transfer rate drops to zero and all NFS shares c=
ome unresponsive. Stalls usually last between 5-15 seconds and there's no e=
rrors logged, though sometimes "nfs server not responding" errors are logge=
d on the client side, but those aren't typical. After the read resumes it o=
nly lasts few seconds before stall happens again and keeps repeating ...
>=20
> Tests done with 10Gb network and kernels:
>=20
> client:
> - 5.14.9
>=20
> server:
> - 5.12.19 - OK
> - 5.13.19 - stalls
> - 5.13.19 - OK with f6e70aab9dfe0c2f79cf7dbcb1e80fa71dc60b09 reverted
> - 5.14.7  - stalls
>=20
> Server kernel config included as attachment.
>=20
>=20
> -Jussi Kansanen
> <config.gz>

--
Chuck Lever



