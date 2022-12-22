Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B476542C4
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 15:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiLVOVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVOVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 09:21:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FB48FD0;
        Thu, 22 Dec 2022 06:21:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMDNxIo024413;
        Thu, 22 Dec 2022 14:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XcHJMFmGAHYpvh9Y2if+cBSZm7INEbk17SP4jop1vuM=;
 b=zRx/dKIpaaejPFle8MYVOdvlfiN654tXucMuhwNZNczuBjR3Y1okp8Y5qfJwkZ6ZjSwl
 I2pKuZ2+93JMo+3ciOX4qc9RHfkOhhdx/W0UooQ9a+a7kknp1etNmfJv98wWXwBMQTCl
 oSFsYnciGAEtZmVvFyzzmcWfL6OiyTB0KWlRbZaZZfJHdbBn/dmNukNcY4NqBrCDwvGa
 D8LTnNMr+h6wAsGowaueEP/7p/PMesa+3zNoyVhXt40F+Rrjnf/m+XDDvZ1RWm5ve4as
 Jc86YZhc5qcHt7S8m9T+boat01sJa73Z000SfgySVmE8/96bOckhpSRCy5b8ee7mJbh1 HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmbgfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:21:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMDXjdT035166;
        Thu, 22 Dec 2022 14:21:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47ec2qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 14:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2c+iazClf9F2ymyGWDFxN/whOkMtp40016dH6z65jkrd/XkUBPYLlmC/i0Obg9Ep5pdDZ/mFvL9MPb3vRztWpc5PA4rLlEeJqUfFsYVId0Y9Z9qVW8YHGgnMcoa7dG1bTDmcPkjga+/NA4hQlYUZBgwpj7Y33H0sC9dMIQC6mfMOgqh8FjhYnL9rq0HyrGCpSc7SMqRfAXBS0JKPLw9U3eSi/39WzwuQOcl1xae0ylrxEhRwWt6SZim7ujZFGE2Akb7BXRsouziGAcSylC6AdDyVQy9XPdFR+k6HWh+znGq0o0QVEboZYUqc7MRpcYbhw1g3yv8Kcp933HWeV10lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcHJMFmGAHYpvh9Y2if+cBSZm7INEbk17SP4jop1vuM=;
 b=P0vPguv++GqdNMsMX2P+Lu0m5HPXTnDgpgohK9kPZATjo1S4K6KBf1aCgFomj/m3vA/SXPngUxw9iPXGG+nwB7x2/YXbeQrMVDw+IX2ovx7uyT+KGU1HLs3lUEz1VhGq+0dYc5TlfVoD738+obOso8p6m+JZHmkyV7J6Ms6Mg2wNOKGzbcsNgxEOiXWaLCAqiRnZSjsZixBbOcQcIoCiWha58Wkz33+xy4dkaWLgbw6YKbG5Ca8I+rWoYbJ51lH2ZwEF2CeZyFjz4ypZZVf5hixQ0atd9U3fgPOoiEYwoT9YOidV5jkmpT7BslnbbTVewQDkv2QXSmtjQN+rozVXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcHJMFmGAHYpvh9Y2if+cBSZm7INEbk17SP4jop1vuM=;
 b=ax2dfWcpR4w+bTxqFUSDcaNW0b/VB9a5cqfrnnp2cgPz2bzTMvDDHxxl6JxLjIDRVSf2AIX3B+mUzhQh9UAUcQr8ciFpRfyZFdFOfz4dpbi+yUWpayOnEQFYNxxJY/Oq8LAT6aifJj7FS9SICg9RnxvAaDlIaSw1MQUn6c1nz1o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4870.namprd10.prod.outlook.com (2603:10b6:408:12a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 14:21:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 14:21:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Dai Ngo <dai.ngo@oracle.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
Thread-Topic: regression: nfs mount (even idle) eventually hangs server
Thread-Index: AQHZFSMVb1dlHuUkzEyQB2fRdyO/kK55RIoAgAAJEgCAAAO9AIAABIOAgACS6ICAAA5WAA==
Date:   Thu, 22 Dec 2022 14:21:33 +0000
Message-ID: <AF3DFAF9-CF19-40AE-8B8F-31D100E00F33@oracle.com>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
 <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
 <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
 <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
 <1A404CDB-95A8-4D04-B76B-91D4F063B489@oracle.com>
 <36902a3dd6ee1a8656548ff5b5eadb88245e2799.camel@gmx.de>
 <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
In-Reply-To: <e51b8b218f18abe00ec76eb911d5b5b5af02f79b.camel@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4870:EE_
x-ms-office365-filtering-correlation-id: 6bd7c926-b4d3-43c9-ee49-08dae427d3d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kB8vsu52bGMhNcajKlFzNCyndm32gwJMlO6krrMqHzvh3rT1Dsm/YmxnWcQ7TBZI7qoiAxrutdkATKiWWLjIRsyjt/+kAgH4jJSDjHfa5P3TICcpaJh9oWvR0WepkOWlilHFyxXqu1MyFSi2tht5vYHrOu2etnl9OS3iEW2eRuJ/6KDc2zOw6bJ3+Ir6Lt9SsHGCxQMVZXmJ5bPi0H0D7ArKA+mhcZMQ6OSKM1WbiqTr3/1Tc4vrh74TvI8dOZkdYlUPGU54Ao8t+W9Zme9ynKPOKP5wjCh6hysgzCgzA+DgiH6usHRks2x+pfYaaQVVDXkONHa1dF/EIh7aDeWVvwUVX9Gl5aW9fEVisTgP5mH+9O8gP/tDgjSdkP3o2Mdd10kUdvPq84DfOBoBlcnABQLg5C3Jcn+Gq0NvivTrdKbrfN8fy//9/rgaDOWyjIjAkBl1mSQLEdzh1EEc2RxYu8NSKVl0AdRmoBmJTm6lui7NusTlQBovBrNUc6NkjLHL6uUObcpqr+IB26Q9UhKy339CMR2/LeA07eG3MxSElhpknAchys9zkHmIcaKoVkNxBJZhh7XV1ECVQ3NWAaigmdFOJa2whh2dxEkKg5VqwmlulAfQxgo6HtcXMCAkVA4Bdod0QHwj2nsFZw6zCI567sl7zM0seU21aXzbK/7pzAeWeZA330XLb4QdSZjaeIebkZxEYxZ52LxKExolSRBmm2jogePsqtrlGuUvekwx06U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(64756008)(66446008)(66476007)(66556008)(41300700001)(76116006)(8676002)(66946007)(4326008)(83380400001)(36756003)(5660300002)(33656002)(8936002)(6916009)(71200400001)(316002)(38070700005)(122000001)(54906003)(478600001)(38100700002)(6486002)(91956017)(86362001)(6512007)(53546011)(26005)(186003)(6506007)(2616005)(2906002)(4001150100001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cWkI8GYA6dDTdr8eTxxijR/nS/VaIMBGRNzYhf9BFyzp+zDU6vrxgYq5/PMr?=
 =?us-ascii?Q?Oh3jQtbds5Bf4jRJ6o77lKFPxJRfOg4cEx5cWzu1WpenvOqo36kDXRxqHjTk?=
 =?us-ascii?Q?CgAdSZF3oIy6GALhkT4jDPiJCoqlVDiyq2RSoi5/0KC231F21YY7RU3HQoT5?=
 =?us-ascii?Q?OSwNZHaLVaVw9rFTpiVZk0h8gRGy1BD1PsZkWc/bpkl8ZF6EawI3rRfXEObm?=
 =?us-ascii?Q?hbKBs95r+GzZV4UlT9F0vC8f5jbXZ4iFlGNrTL88W5vupZltuQOlBK6NEZRh?=
 =?us-ascii?Q?veqBGncJeGWEU1reLMTBmRiSx1vChuS72wbI9s6tfNpbetEL2mU9vLW0+WLL?=
 =?us-ascii?Q?uyPq53lZ8B9bvx9CpWZtzvcW+NXH/DZ6+P1gINPe/nrvGO8T5z0FZcMtwTFl?=
 =?us-ascii?Q?HgMlMmPhIzy3Cc1DUfoz5qSzdazurUzWrLiI3scZK6miGe5jBi7Bv9wcotRx?=
 =?us-ascii?Q?R9ASNqP4j0zDJkaHKegskrJt11ySXN4/RT+VUMzIEVP88hziUWxd6Y6LimJL?=
 =?us-ascii?Q?z8yfzpb4gu0Cgm+p7wQhHsrOE7lHZh/hZdiC8k1eC3b4dhHLOxEIf5vnG2mN?=
 =?us-ascii?Q?7ASfkY1kMvdGqNxb4A1XBUB2SPDFHfM3trdCFJN8eJyU4mSj3QqjDvwrImfM?=
 =?us-ascii?Q?HOP8HQ/TaOYxxN1DNhHBbiorsxBYTrJP6X3B4Jb765ws7MgE/Htvrz4Rip68?=
 =?us-ascii?Q?n/+OYaFi/+efeM8SMm6z0lFkkamlpN5iUKdv2OGAjE9VFHu+FBnfKl8x9Ptm?=
 =?us-ascii?Q?HAFE0Vljz/Vr7MrDfTDyrlp2ZT/yp0wpMRyTq/XoJyqbjhcdDmej0GaIqxkl?=
 =?us-ascii?Q?0L6A8kDhzi2Cm+5Ljs5B8xXIlxhQlEFP8+4sK3A25jQBmijk0T1i8Tj8lunN?=
 =?us-ascii?Q?Sdks14KYkMvqz/kSApTUcup12sUaxdLelJcEC1GiemjHF2PO9ZBhuo+293Dr?=
 =?us-ascii?Q?yj8nkLhfcvjs/4mI1NEQUY+SV9NGgUfa0z7ZXe8cpknopAp0gjGc7IAcnmeW?=
 =?us-ascii?Q?Yn39oC9IpaSVKh46vALSOvC378xJa0oLrRjUkX9Ha37ssZ6GhjHN8ARleSoF?=
 =?us-ascii?Q?DtXOBXq+JFNMQpCFwlpehqJxVN2tlrY2WeZjrpDswy4jFyMbtRNTapryxUvQ?=
 =?us-ascii?Q?Jz1iKRISbi+KjLsgQ+wdPpMRcOdDKTAE1wFP/HuPl/tSEofQ3VfWFXT/4Imh?=
 =?us-ascii?Q?GT7kFRYkJ3jLPzg1fYkrBCun9JkjOI0/KS55okGxFtWppuBG7oULIlrdg48q?=
 =?us-ascii?Q?FY17JRL6R/UCopx1Ni9QkbIBOIqYBinQM9fkVcjeerH3YsscEXip4jKSoM28?=
 =?us-ascii?Q?Brtu5GJ7NGkYblckc+QfxGICO+ZWWUdeaTjfC4aXMdbZCITxUlwYisQ0J3Sl?=
 =?us-ascii?Q?MJIuZolHa2ciGTAmV90HeeASGEUUMZSQKTapv242mfWMrNXbfnQ9Fu24nTm0?=
 =?us-ascii?Q?7Ep7rAxQYsStkSGKYnpcTgQ5txKV/PJz0HSCckYSRmE1kUZcdzimSU/qpHjM?=
 =?us-ascii?Q?QFs3l2VQ5kU6VMHwADgEC1VCO533Ex8SBTPBiJ0CdP9k7AaRz6lzqcAAjx3k?=
 =?us-ascii?Q?bMev8b8tWiEZxpDKuAwlyobuBhyhyI5JM6SjYUGp01pV8pc8LPBbAI2sU1Qq?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C0D98C0100B87438B7945BFC472E5E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd7c926-b4d3-43c9-ee49-08dae427d3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 14:21:33.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SotNp0BrK+M8Rz2Ut6lm1XwGMovPGsttZA+b3zTYRu0jahOfFHrY2HeiSg6nuCGTgigczFUA230BcmBLfmWA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_07,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220125
X-Proofpoint-GUID: h-hY4UqyZSKdwbN1Tzh5DcmVC7CdNGTR
X-Proofpoint-ORIG-GUID: h-hY4UqyZSKdwbN1Tzh5DcmVC7CdNGTR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 22, 2022, at 8:30 AM, Mike Galbraith <efault@gmx.de> wrote:
>=20
> Quoting previous mail for context.
>=20
> On Thu, 2022-12-22 at 05:14 +0100, Mike Galbraith wrote:
>> On Thu, 2022-12-22 at 04:42 +0100, Mike Galbraith wrote:
>>> On Wed, 2022-12-21 at 10:56 +0100, Mike Galbraith wrote:
>>>>> 6.1 didn't reproduce either, so it would appear to be a merge window =
bug.
>>>=20
>>> Ah, not true, turning evolution loose in nfs mounted home and letting
>>> it refresh mailboxes while desktop box was kept busy jammed up 6.1.0 in
>>> fairly short order.
>>=20
>> Well crap.  That was _not_ virgin 6.1.0 after all, it was 6.1.0 with...
>>=20
>> 44df6f439a17 NFSD: add delegation reaper to react to low memory conditio=
n
>> 3959066b697b NFSD: add support for sending CB_RECALL_ANY
>> a1049eb47f20 NFSD: refactoring courtesy_client_reaper to a generic low m=
emory shrinker
>>=20
>> ...applied from poking about yesterday.  I had given up on those as
>> culprit, and intended to pop them off and rebuild, but they were in
>> fact in the booted kernel.  Oh well, booboo could have a bright side.
>=20
> I let my desktop box play server/space-heater for a long test session
> of 6.1 with and without the above series: with, box bricked 3 times in
> ~5 hours, without, 0 bricks in ~6 hours.  Box says woof -> duck ;-)

Thank you for testing!


> Given the similarity you mentioned, I wonder if my bug is perhaps your
> sneaky bug rendered somewhat less sneaky by that series? One can hope.

Not likely: we've seen problems since 5.19, and these patches were
merged in 6.2-rc.

So my question is whether you see a problem when only a1049eb47f20
is applied, or only when all three are applied?


--
Chuck Lever



