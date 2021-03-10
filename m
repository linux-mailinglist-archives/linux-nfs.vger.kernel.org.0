Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6D334231
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Mar 2021 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhCJPzT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Mar 2021 10:55:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhCJPys (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Mar 2021 10:54:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AFTHrE088592;
        Wed, 10 Mar 2021 15:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GqLZfGhHr8XDDPiKlb77NuPBC1Vvt0eztGytRfa9dvw=;
 b=Ybjmw5bbjxx9NNKPyaRFGUJJALr2xnpcJVOq2RR+o7mUQNsLVR03E1FaseQvMFU8rycu
 prO/o/0c16iu99Yh5xpvBIWr5GRHS2XPAFR8S/wOrZf0+0jebb56PpGn6WYVemEbUXpP
 GhE7GPnz3yMVRUJN1+eZjNkxtnKhMsVmMeskmYWJlYhhbfPuVfp9+bjeC9E3IC/jDyvg
 kNKSyARzXycv8KneXWhdU3CnfltxmiNXFwaDvxsrnTEzv92wB8+nye35xKp0ume7heUt
 J2yAdODJq2gL7X4FCpaz8i53AjXeF9L6F+hbjVCrf9iPYywRS0A4E2VWBJb/K8oOdf30 hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cnbe1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 15:54:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AFpLmr134729;
        Wed, 10 Mar 2021 15:54:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 374kgthu6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 15:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTKu7jtM9d5j5cufTaW1Qq/DkrOTus8URt/tqY/YvMgz0Y3dGPV3BhDBxJqc3pReM2K5LcAUTkcoQ9o068idzFQiC00Ea2uryTTrFtRbRNyfU2pNOMHYhZUnvZJPcLS65V3W7fdX483j1VnXBQsB8h27R/i9LQH12xHIVw+8X5WTD7LiURe0FaUGzeM5LRiT3QFkuZyNVxpyFPQQwldsNuDYXzIKnaKeM4FcsBO8eLFWtPhIEr3DeSTQwHue0dOkbeLXfOF/Js3X1UdUd1g9ELml2rqP3+ZSTZRZMvFp+J3nue/VEo89+IZu9IVftCBCCY0pbbnehLZ2UrR87VaBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqLZfGhHr8XDDPiKlb77NuPBC1Vvt0eztGytRfa9dvw=;
 b=XcgM+MdMbo7QMbXEkaKy/oZiV6SNiz7thLfB92khwajsrGJV2E0pqLCd217z8LdtUP+r5yOn9xD6NjtLNrMtnxOwdKov/+3hA3SYVVWYLn8AUAEIL9wlpjkxiHXxrADQWM673ZWSy3WMahyV2FYmMNpz1pxc42uUznxdGHWb6hgVyZUIH+7SbuGZUXEyMSnSqPHZ03Mnva/hI8Z/6Zz8hF3M7KJY+22hhV2FcXfgPRpBg/tJXffCxv2jVhSRs0GgbF6OD6m5SQTg0Pkdf5EiiHUK9hRGen6o4k+Ckaa5NElZexsLmuzXK0CmAkwafVINsKRP6wzVVN+EnnKNPGbgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqLZfGhHr8XDDPiKlb77NuPBC1Vvt0eztGytRfa9dvw=;
 b=m5KW+eujXMOxROwWnR8ERJJGrczlfWonFjMuouF8H9bciYaWA2K4YKX285zvP28mRkIqbz+aNkMlR7SbamOzvYUA8ldylhzaofqq9e39Oauhss49ighr1iVVJaA57szT6+4x1RVlzDN3X+l8o4y721l95wmYEnM1a5oXlw1P6eU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2646.namprd10.prod.outlook.com (2603:10b6:a02:aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 10 Mar
 2021 15:54:40 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 15:54:39 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix dest to src mount in inter-server COPY
Thread-Topic: [PATCH 1/1] NFSD: fix dest to src mount in inter-server COPY
Thread-Index: AQHXFPJJWcd6C1zvuEKJ5gcW9d20LKp7+DyAgAFpOYA=
Date:   Wed, 10 Mar 2021 15:54:39 +0000
Message-ID: <397549B6-66F9-4E6F-B538-133A41859182@oracle.com>
References: <20210309144114.57778-1-olga.kornievskaia@gmail.com>
 <88214ebd-c902-2886-d66b-2eaec0b14443@oracle.com>
In-Reply-To: <88214ebd-c902-2886-d66b-2eaec0b14443@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96600422-02de-44c7-62cb-08d8e3dcd04c
x-ms-traffictypediagnostic: BYAPR10MB2646:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB2646EC91C292FB0D9B8E4E3D93919@BYAPR10MB2646.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24hkudM8EjJFOMY9xJsoze4NJ1AUDYgjEbKVRZj5hZ63IIyUVpHM3ishkLSCHJ7CzzBwtbpmOiXsUCJ3NKuZWCjCCFfi821lZtOIVz06wCWFTiVHDrPjAczT3tUt83wyUHKUNYJsQ6LOcPak7Kyj0Te/LSaGqSG09ZfZLX5Es88Tr5mkDNqKVTaJioo+z+HqbHQarzeA73ysVXebyL5l1eaVnCMqkrmTtNZoqJqTUwlL+CcIMpKNmTe7SwlbOSb4bod3o+rdiZa0t0avar5HCp4UaeMEvrdy7M4GOMc6vfxyEh4hDq6wXol17m5hjbphRI3I9ofSTOaWGsRPIDSbQh3pIiWejJLSJ3yFoK7M4yVYnf+1xjFU91gcQzUeE+49r1X5DFVWquipzxxVsavKhDWOfeFIaNUqAqEXi0nl5JNZmuu/2Iql4ZNZ8qgxlztNJQgMSYD7CiCL0IHdZBsDrAkOoA52q3FuG1JfEX88K0kmxfqAcdUFeGTXguUlOnWDP17XlSIinh2sdfFaOOro5qAoaW7u5OoY1wM0aMjI3lWpgzSW4gE51F+2x8Cay2Df7AvDCuG/4ufGleR8Dx0aEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(366004)(396003)(36756003)(2906002)(53546011)(478600001)(316002)(6506007)(76116006)(4326008)(71200400001)(8936002)(8676002)(66946007)(91956017)(66476007)(66556008)(86362001)(110136005)(33656002)(66446008)(2616005)(6486002)(6512007)(186003)(64756008)(5660300002)(26005)(83380400001)(54906003)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lrKh3tZk/sEcye98uz9Fm1wpOo0ddGTCbdD7On1eHyy2n+PpXnHH4+CxmTtt?=
 =?us-ascii?Q?+zsxEACgtIQGyZu0VR+VhYw1wiDJnifWKPt2rA8cvy6HVAdbCK2zUV1EOjly?=
 =?us-ascii?Q?nxlZZxj3vgplk7JS2x7wHh7tDaoalc9uXb1SSUUMZ0Y+ajOvBzxHFsBQjcsr?=
 =?us-ascii?Q?M4Y9Bq0pJlEAzw1cp5n3eiI4dmgswzhAqm70ZRDHm2UCK6BInbg0qRgjJ+wG?=
 =?us-ascii?Q?KduiQJ9KAYTRegBHMqsofngU75JO8i16hs7Kr9vKZBluEFE4ySY49Im0SNyL?=
 =?us-ascii?Q?v6c7oiM+uMTK4qvcvnUICDNZLogND1Bw1cq9BqKYF0MfuCeI4v9mNZxLRSYk?=
 =?us-ascii?Q?Pn91J9N63EodgAczTVbrSL5qIoi/nY0Tt9qQ67CoAkNungv0UGiHMSUQ0Sle?=
 =?us-ascii?Q?JS99QRTOxw0H1dB9vJin7GNp2ClrsQkA1oRLV3dnVfBXtI9Ptvh7GE50AuTb?=
 =?us-ascii?Q?I69MTpmHUYn1s3eXU2/71hNBAO/bsa3MQcYDa5eV+aJ8Z2c2Y3X0O/hcdawg?=
 =?us-ascii?Q?fRYD73xWOhQpOR3My8fkNat4RClX6wYlL54234g2UnmFd7lusov60bEEZsEF?=
 =?us-ascii?Q?Cn8eqfyHJOmJUAli8L4hbmQ0ZTFZObm9+0RAmDsOL0QxHXtl0aJ0harRPO6h?=
 =?us-ascii?Q?ZShPZmo0GjFYFsUi9FxFkszDg1iTOnq18b/XEElosVaCTguClY6wuH/5K76Z?=
 =?us-ascii?Q?kdRhnbSYWfTtIf5ThDdHNKbmNTm2FFdq/QRPkKuEaqUKGG5o4OqLz825RZax?=
 =?us-ascii?Q?rw1PMN6mmoF8jF8RjZO/FXMG5q/pg6Yu8O/4+Odu6n4r8j4L55fVHvSWPGaD?=
 =?us-ascii?Q?+iIDEZAdgaPdjdSAnsJVhnuLAwWP9xx+vshItghi8CT7ZJlppgIAuJ3KoqZG?=
 =?us-ascii?Q?KwW8qqGsGiFL96rpMTZpWWJ8Ke/JcuZCt3hmdjs64tNuwKrr9CXw90J2uzAI?=
 =?us-ascii?Q?vLvlJCj1+B8vkArnyUUbPG2CZxC2E6m1/5+UYnxU/BwaVWK00knz3NKSD78Y?=
 =?us-ascii?Q?XoeYJ6qVGALxaJUz3H3ceJkVaarKBR2WNPh8oXdpmhTPTehwshUekSQmN+Xt?=
 =?us-ascii?Q?GFg2OAtx+n/furAF+/XmBpJeZM1/YC5QHZPruQWt18MRizzYkhl72ct8DHAG?=
 =?us-ascii?Q?6tWhQGSn2YZiGoyte4smSdc/Rnuy4/YLAPPUfjb2F1QPJfT3efC58r6+al9L?=
 =?us-ascii?Q?4Nus3oOdefs/4yyI8LTSfpS5CMgsMtNMkrHnvKE6rr3ro1ZKo5y+5rJgbVZT?=
 =?us-ascii?Q?hP9mUATXU2qJb9ZhSKQBlulBk07gc9PjGh5sOOy31lTI3s+kX3Ell2c4dGwT?=
 =?us-ascii?Q?Lz7Ql41Nf1ZZFCV/gVTyT8aM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <549883E32DA09F4995F5B0450C906E99@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96600422-02de-44c7-62cb-08d8e3dcd04c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 15:54:39.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZwdu9J63nYxtpKfJiiJEbhAvA4VLQj4wefiRQYiAkDHnWzQqrDJ8WLq1i/wybbu4RZAV8j1rKg7Kn/+30ywGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2646
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100078
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 9, 2021, at 1:21 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> On 3/9/21 6:41 AM, Olga Kornievskaia wrote:
>=20
>> From: Olga Kornievskaia <kolga@netapp.com>
>>=20
>> A cleanup of the inter SSC copy needs to call fput() of the source
>> file handle to make sure that file structure is freed as well as
>> drop the reference on the superblock to unmount the source server.
>=20
> Thanks Olga, I tested the patch and verified that the source was
> unmounted and the file resources were released properly.
>=20
> Tested-by: Dai Ngo <dai.ngo@oracle.com>

Thanks to you both! This has been added to the for-rc topic branch
in:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

replacing Dai's earlier patch addressing the same issue.


>> Fixes: 36e1e5ba90fb ("NFSD: Fix use-after-free warning when doing inter-=
server copy")
>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>> ---
>>  fs/nfsd/nfs4proc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 8d6d2678abad..3581ce737e85 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1304,7 +1304,7 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, s=
truct nfsd_file *src,
>>  			struct nfsd_file *dst)
>>  {
>>  	nfs42_ssc_close(src->nf_file);
>> -	/* 'src' is freed by nfsd4_do_async_copy */
>> +	fput(src->nf_file);
>>  	nfsd_file_put(dst);
>>  	mntput(ss_mnt);
>>  }

--
Chuck Lever



