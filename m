Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8C536890
	for <lists+linux-nfs@lfdr.de>; Fri, 27 May 2022 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiE0Vea (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 May 2022 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiE0VeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 May 2022 17:34:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23C6EC49
        for <linux-nfs@vger.kernel.org>; Fri, 27 May 2022 14:34:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RL0gLi031991;
        Fri, 27 May 2022 21:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I4f6w2G2MEMDfBT6xW/0Xec01bUidpJuI7B5H0q2lhM=;
 b=dZsFjgcokJUO1VaUYI7MJBBA0fCNbJqDtEK+d9SszGnp2rq+K+7c2RfxFkBnNd0i0/nD
 OztgswpofXTS71zPDuYAkoSf6FAsKPKQN7CbJQT+szpXD8li6JGSeBCm6tmzd02HLRrr
 6XGZecReRBCid+OwHcIdit+iU7Q0pnJbuvysJ4j+ggRMZGHAjCIXugyLh/cmzxgBpJuO
 UckIfAK85OSmbFNcqa2BrBYERiWVyocTO9cZ07HkkmWGT36CGaeKy0s+fowLEFfgrR7J
 xnTgMZAO5vXParCWX4BjoTFz4gfmaxZn/IBVTKg0qDxpLdJVz71QnjWDzvJm2uBWPp2A JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tc0984-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 21:34:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RLGHIj032714;
        Fri, 27 May 2022 21:34:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wyq7k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 21:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfoHjCv95lgr6twlZawHvTkwcz4/xmtHYsXLuzcWxf2evXvNPrRpV7d6bOAaRJJvfGcJG5Su9EaYVv56xAiiHqDQhVNptM4FoxRWyN55ZWyhFKM1Y7Hsu/g3uFHzJp/kVBkAhq9YFGMHLJr9MyE77kMGe8igD6lOy6hs1/cxGmGFCJBKMQZ8Eo9DRuJaSr6/Lvrs575Cxv0SuTUZ3aCL4dt1K2OUcwp9ehFAzNIIK24BH/Z3g6Gewn+X653rDg+wa79RzoXqiuJ7YcDt/QtgtoYTox6EvCIX1oRA0BVcezv2KDNMtgmr/jqxU5k6hlIkEwujNHMTVc6AyrsZvQ5+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4f6w2G2MEMDfBT6xW/0Xec01bUidpJuI7B5H0q2lhM=;
 b=fSNDfdDgrRIxaVlDYzxjAI1TcrZ+XM6bOuM4znFWO60nLfIUeSYTTgoP4slux6or4Oj7SJso+ZFhhcGk7KEvPb0xHrH/HfHqp6s8jIIeq+M9xx0UqntO2l8srUPEBmyXedhuwbCLI+0DeBrD3z5M1oS5wsy0ZrnllKSE80FPSVbSoAcuJtPX8AEyblFki8HDQQGvd1BpUaJrop0yZ5p+35lIarxopgtZ/xRyBLlRqm4W8Be0E5GhWbBblccbXes2ebwPsaGsCbqFD0Z0OkjeuBuZ1L7htoXv6WzMjokm2gzvNOjJ2ghNzq/zaV+2UN7zkkzRAK0Khy1Vmv9hd2GaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4f6w2G2MEMDfBT6xW/0Xec01bUidpJuI7B5H0q2lhM=;
 b=UtvC95ZZ35geGzWm0iFIQ/oIQgvJZN+RLhjI1RfUYksDZXmQ0M8LGGOztw+CBeGcIUQyrBtCdxTOUMvGiSVtyMoOga4f2lga7OVxMvABQYdYEJTesd890/RAGoSvs3osU6XFckVWhTpRYhhjs4jjYoU6KeHe9I8/UXveYh6FaJY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2928.namprd10.prod.outlook.com (2603:10b6:805:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Fri, 27 May
 2022 21:34:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 21:34:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Frank van der Linden <fllinden@amazon.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Thread-Topic: filecache LRU performance regression
Thread-Index: AQHYcfvwqM9TwnG0lkutiJn4EA8Bxq0zLyiAgAAP6gA=
Date:   Fri, 27 May 2022 21:34:18 +0000
Message-ID: <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
 <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
In-Reply-To: <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edfaac1f-4918-4250-cb5c-08da4028a802
x-ms-traffictypediagnostic: SN6PR10MB2928:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2928E59FAB7D879C5135DDC993D89@SN6PR10MB2928.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ol+kxIhXZsamMkpPlIzDJgDtjIWiz/7SasA7ipe/T0KeQeEClLBNiBV5wyyg4f9gvI00h5FFBrrH8/omEOjV9QraZVxNxWFh8LoQe+W62NMu/DFNPOwnqCD4kuNN3HLQZa/id9e7IGKlAJe39Lmot8ZpOF/x59THr30qHURI9ADPGdrEAPWGwzcHm/VCUTW0IFiqGebNlbAJbBlKyqTmDf3FckLDjAA14SMcCgIohc1483s4EurdfxHfzKJ2EQ05qsPKDKDo0TgHcXFVvffi9lQyAQXpt4LKzsHZW+9nbPOo9vtbS4cjsVmxL8f9+VqvoA1Bq8xzAO1+vQ1zY71ZUZ1Bo3G9sq4sYS3NDIQhdI2fCF2aVDpFZJGIcE5FmX+ev497fFodniK1rgWSXvepz3vHXj4AOR5GcJh5pkI+/SV0pb3uKA1U5IjEiRfsX/ImU+tPVxVM/Q1ov1VEHO6QgyVHpSQuHUxk5tXzdnEOZi4bfUmXvTxGEMDf2JnE1XubXCubMzFJ9YgInbzYK/WvJPFCZas216hlp7+kfN1ql1RRqNUGZsKrP1gfyfrKwGU39CnL0+qAJURGEM3UUEcbnyibqqAOBCPAtIHJHi1W9d+mS3r/fw6miVQ7zy1FO4MzuI+2Y45lDyOVOhu7d9Q02acdiM9PLok4SRE7KOHgvZ+Q5qNoMn6oIAnUOcTCkPY7DCNsBa34/2fDVN4gTDc4dISYoBZ0WMdwbvtJWYPGvkmTplAUpqPPi2SuA/71dIo0IYwsaChmJ3NcxZb/4xo6vJQ3H0JrvrnZlwaiXImXdy9Ny7IZKUwaFgBhZxy5OQ/E2ntrwk2/BylpvwLMBveIeIG1vjTh1Yu5dKxZYEssRgsqoSM4RsleEc0PvA2onxry
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(966005)(54906003)(6916009)(33656002)(83380400001)(3480700007)(2906002)(6486002)(508600001)(8936002)(36756003)(5660300002)(316002)(186003)(71200400001)(122000001)(76116006)(91956017)(66556008)(66946007)(66476007)(6506007)(64756008)(38070700005)(66446008)(6512007)(26005)(53546011)(38100700002)(4326008)(8676002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?78FF3LbHIQQfVK/PFZpG0E8NKOqiZ8keNQaBszvKhYk6aJoYMe+iMIoXPpmP?=
 =?us-ascii?Q?gWiDN04vnpAKIzKy2bWzKDQedEe/2+UTn4EWD4yEarMHdO4sEa5if0RQZx+p?=
 =?us-ascii?Q?8M5PhdbFMaYpYp9FWMPAxrJ34Wshjqs/hG0yT9mE62xkqzMDJA0a9nU72+sF?=
 =?us-ascii?Q?j1XDLSXz0QRugNzmO50MwIj00sPUCuSHIxWRvaVPh/OTcW5bpUNql+gBnc8Y?=
 =?us-ascii?Q?oxKPRyHTp5Oc8vYctJjDE5g690e/2bILBmwsqgrxvQaiCBfqJIZG/nhTiKts?=
 =?us-ascii?Q?n9hauQx789xiCvTlDTCphL6f3gyG8++ORgCbqb06eVWV/r6O/+YQC35I3dsX?=
 =?us-ascii?Q?L9y+8JgP4XoF2FfksgMYUq1wbAPcce49et/ShPrq2vavKYXmMUqPGSHaPxY/?=
 =?us-ascii?Q?FKptXQWS+RbZRvg5kJU5/h7xn5vZkkJgM8M2hfLnaJ/j4qfS8YxKeDSv+dqy?=
 =?us-ascii?Q?F0uRNGpnVvkpxovvqM//o7nf61/4SYf689J7Y/a+UTp9JjhxrZYIyyYty/u9?=
 =?us-ascii?Q?Gfc1bkaur1u6FRaYhAxFAOcaM2HzhWSKhGaYgZBZrsrrrFhuz3pA7DOagOr/?=
 =?us-ascii?Q?zn2lxAaCHPJcCSRBNwn0KQWTTIH5F1rUu8s8Tw/a0nhz7rxTRcezLGOmhQa2?=
 =?us-ascii?Q?n4ecvYdYJRfysi4r0tmfkV6PM4fH/HqiQ8+wo1wK1KGd14tBjBAopMre7B7J?=
 =?us-ascii?Q?r64r/mUMdmpTAhNiLqEuCjVxw96myrzO8knTHgBq8TCoJmWo0A41Tr7qO5Pj?=
 =?us-ascii?Q?zEaSVC4J1DXdeZsAMaJae3in6BsHgF3dDLVVsXEM/o5cBRnVK1m/8WA+gnxH?=
 =?us-ascii?Q?IbXBHRzZyslw/Da3eQGuUqvYHo7x3y1Ihp5ELg3wVYQlU9mGBANMAfNUht3O?=
 =?us-ascii?Q?wiUgcxFwW9kwm8eCnV2x1laZ8+2hJqw5ClyUDd7teFtE9SJJRhw5nyRnLfQ6?=
 =?us-ascii?Q?UUfPGoYUFiT5fxOeQrKakwMxGGVCpwU6xMFs9ipqHWD2y3HgPiV//Z5LZSlJ?=
 =?us-ascii?Q?R+UnkDDBlsGbTpdPlvZQhC4ceX/IVvEdT3HMnYb9lwy5jqq71IUUGaWJS3oO?=
 =?us-ascii?Q?XVzKwsoTRzvm32bS2AqYLlMNm8evmDO8xerX9LU4vUDKz+oNr1D5ACaKRQxk?=
 =?us-ascii?Q?eTky7DRLNNKfsRfodSQ8gffn/ApQU50S+rYP9RBxG4VSk8Wvp7uVTG8qELUy?=
 =?us-ascii?Q?t+RBBiw8biCZkx5xL98CXlWnTf6lJdjtHOziWk9wXf+8e3+vJZsiXVi1mttY?=
 =?us-ascii?Q?ePTSCz9B1qczauaEBUSQ/1VyMyiXv7g6dqKL8QqyNgZJn4wFQUtsifn/Kqo5?=
 =?us-ascii?Q?CpG+c/tc6Eqle9OuUuFMb2hRWmhlnFH3tkmuot9apZodtHrECiSkb8zFV5DA?=
 =?us-ascii?Q?RLCChgb5qbWB9PezGXe/9Vl4Wzc025YscGzqn7qY1YSE/VqDTagI78ULT1QI?=
 =?us-ascii?Q?PivA62LQpoT6rH7wKi1o5UoHUFmqMDEVFlnAnZfFmMfC4S6KeE5FX9tbdd0p?=
 =?us-ascii?Q?v0+rLA7IPjIEpnTJqWxm76ZTaDaoa9Nv0+c+10N0OtjIxBSvAZeoewDBcVyH?=
 =?us-ascii?Q?rj2VW9IRcG96aW/ksRUSUw4wK6wghSUVo/HNPiW67SCZ/UaAf2AjMQFf8rMU?=
 =?us-ascii?Q?mc7pjIEvFBH9UD9YtXC5f5yt8hdF9p5dTbuPJevmF7jXBZoHb7Cjnv/meImw?=
 =?us-ascii?Q?nlc0Iy4qcdsvoFEMXeqwCixQGGFprNhEOArea4f5H22nmBCHmHHofSvcx71R?=
 =?us-ascii?Q?XY6s64clmyWqZHmDaWku++HSO3kyrKQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CDAFFFBD664D5B47A352437768D7F908@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfaac1f-4918-4250-cb5c-08da4028a802
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 21:34:18.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8evtL0AT14Ho4aETDU/cM9NyWxAWXJSijYQoypuwCHlQCM9Q1l0BbFOe3nl7E+iA18L1GqQZROKUzD3DO4DQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2928
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_07:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270103
X-Proofpoint-GUID: CXOGq8nVixm_d4_gYon1UEq7LuPBx9jx
X-Proofpoint-ORIG-GUID: CXOGq8nVixm_d4_gYon1UEq7LuPBx9jx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 27, 2022, at 4:37 PM, Frank van der Linden <fllinden@amazon.com> w=
rote:
>=20
> On Fri, May 27, 2022 at 06:59:47PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>> Hi Frank-
>>=20
>> Bruce recently reminded me about this issue. Is there a bugzilla somewhe=
re?
>> Do you have a reproducer I can try?
>=20
> Hi Chuck,
>=20
> The easiest way to reproduce the issue is to run generic/531 over an
> NFSv4 mount, using a system with a larger number of CPUs on the client
> side (or just scaling the test up manually - it has a calculation based
> on the number of CPUs).
>=20
> The test will take a long time to finish. I initially described the
> details here:
>=20
> https://lore.kernel.org/linux-nfs/20200608192122.GA19171@dev-dsk-fllinden=
-2c-c1893d73.us-west-2.amazon.com/
>=20
> Since then, it was also reported here:
>=20
> https://lore.kernel.org/all/20210531125948.2D37.409509F4@e16-tech.com/T/#=
m8c3e4173696e17a9d5903d2a619550f352314d20

Thanks for the summary. So, there isn't a bugzilla tracking this
issue? If not, please create one here:

  https://bugzilla.linux-nfs.org/

Then we don't have to keep asking for a repeat summary ;-)


> I posted an experimental patch, but it's actually not quite correct
> (although I think the idea behind it is makes sense):
>=20
> https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel.o=
rg/T/#m869aa427f125afee2af9a89d569c6b98e12e516f

A handful of random comments:

- nfsd_file_put() is now significantly different than it used
  to be, so that part of the patch will have to be updated in
  order to apply to v5.18+

- IMO maybe that hash table should be replaced with something
  more memory and CPU-cache efficient, like a Maple tree. That
  patch can certainly be developed independently of the other
  LRU/GC related fixes you proposed. (Added Matthew and Liam
  for their take).

How can we take this forward? Would you like to continue
developing these patches, or should I adopt the project?
Maybe Matthew or Liam see a straightforward way to convert
the nfsd_file hash table as a separate project?


> The basic problem from the initial email I sent:
>=20
>> So here's what happens: for NFSv4, files that are associated with an
>> open stateid can stick around for a long time, as long as there's no
>> CLOSE done on them. That's what's happening here. Also, since those file=
s
>> have a refcount of >=3D 2 (one for the hash table, one for being pointed=
 to
>> by the state), they are never eligible for removal from the file cache.
>> Worse, since the code call nfs_file_gc inline if the upper bound is cros=
sed
>> (8192), every single operation that calls nfsd_file_acquire will end up
>> walking the entire LRU, trying to free files, and failing every time.
>> Walking a list with millions of files every single time isn't great.

Walking a linked list is just about the worst thing to do
to the cache on a modern CPU. I vote for replacing that
data structure.


> I guess the basic issues here are:
>=20
> 1) Should these NFSv4 files be in the filecache at all? They are readily
>   available from the state, no need for additional caching.

I agree that LRU and garbage collection are not needed for
managing NFSv4 files. NFSv4 OPEN/CLOSE and lease destruction
are already effective at that.

Re-reading the old email thread, I'm not exactly sure what
"turning off the filecache for NFSv4" means exactly. Fleshing
that idea out could be helpful. Would it make sense to simply
disable the GC walk when releasing NFSv4 files?

Interestingly, the dcache has the same problem with negative
dentries, which can grow without bound, creating a significant
performance impact on systems with high uptime. There were a
few other similar cases discussed at the recent LSF/MM.


> 2) In general: can state ever be gracefully retired if the client still
>   has an OPEN?

I think that's what NFS4ERR_ADMIN_REVOKED is for? It's not
exactly graceful, but the server can warn the client that
state is gone.

Also, I expect a server might recall a delegation if it needs
to reclaim resources. We've talked in the past about a server
that recalls in order to cap the number of delegations that
need to be returned by the client when the lease is destroyed.


--
Chuck Lever

