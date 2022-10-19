Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6360D6049B8
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJSOug (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJSOuM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 10:50:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566191645C8
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 07:38:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDQswU018004;
        Wed, 19 Oct 2022 14:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0JgSpEMK8kjzYyjAtXq7cOSTmDeJHgo/6Rgw1nprArE=;
 b=HF0jQPQvFnOarWdYxShKnpLwO4hIFPLiADvx8ANDIDRjTP+KLrfVnhe5R2XlV2vYP2vD
 2ghPSd9/OgorUUtOAeBqZ6KoLefJltSxlcePXPtRB+XOAL8MQsVIqoNvesYZEXfqhRra
 ZGG2XzZZHN79UC7qU9e/BXmDB6endhezOOxXIhBRywGdSkXPzyAd1ZvodYs6qOhbHrS4
 SXUbivwgLL09Tg6Q13SPIKhqrsExaJh2YAkYaBpuotns2FWYefbzZg/oUftXYoDtwQ0H
 9oQ52yku1jeWuFhQeeTHiy3Jzw1WCJxEEZhAjeuGWmUDqogFVOzQzdkz3pKGGkxUnoFN Rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu026jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:07:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDZfn6018699;
        Wed, 19 Oct 2022 14:07:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr15c2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkSZX1trD5TaneMoFHs4YZXdm6vSvK2+numQkvGJP3WW5mvxirOA40YHrTSWR0t/Oy783y8d0XP1m/ZCIJnuScyrmR2IK24gpapsTQ6pOXmDsuCE/df42/ARHC+56JzihwaJ2yXCHwoK2Wt6gdjt0p3ojJ4atEgSEVLIPQ9dTqWBuUJPEnir1Uctp/qwwnud2sYfOIsGHtQPrlRCWxgpqiJw8BUmCh4Y8JNZ7VADgSyXkdztZb5NFVuelxiXAdPt0+QZ55Y900q+bLguZHqZjOyH9VnZZg7DMdc/eXg4MQ42YPCbyfjpy05ivsJUoL1A7OtMC0jXE5lGRDyMK91pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JgSpEMK8kjzYyjAtXq7cOSTmDeJHgo/6Rgw1nprArE=;
 b=fjuoY8GJ42/l8P18w1wAYiBIalU+6kwQ3Sb75FLQxtCtH1yASXgnxT7+18OokQfttVdU6p79GeArs2S/ScdBd9892/dI0dSLh1/svZvTlJVx7iiZazjZdsX9Z65x/xM/Rs8tI4cTTFazIw9gkLMu3QQT7pOdHJ9bLPTu/wyJXJJY5jUZejuIFzPaEu7GSj3fv7sioEA4plPeJUUjmul6qKgSRMdBdJK63/onvTPrdQWoiAo9insjXTU2I11z8bqraoQcxW1qLFiJXvPtM5acU3dZnu2fuEVF5xip9HMAffvgomqhpg9EsA/O1zB5OGX98sPXBSPjS1KxdbZcjXe2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JgSpEMK8kjzYyjAtXq7cOSTmDeJHgo/6Rgw1nprArE=;
 b=GhtsAMjrLg/IB2Z/iUMKaXbS3p4xU1zxu8KSa3Knuw3OoyCiempqQPa/nPqrSLA23M/HGdiHrAnf18iFNTkYmMgkmxcRhtr/Ds8K61uBJjDG3t/TNOMwT/R5ndO9LC5rP09iijgF6Hw1IjKLh126BTa/j5YYbhMNBMr+Qz8w2cU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 14:07:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%4]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 14:07:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
Thread-Topic: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable
 nfsd_file garbage collection
Thread-Index: AQHY4ywL0+TmiIKEZUCtCfoSHjd9zq4VlDkAgAAtlAA=
Date:   Wed, 19 Oct 2022 14:07:09 +0000
Message-ID: <13A632E9-3E52-4968-BEF3-6439053ADD2C@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
 <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>
 <c7d649582724d8f2fd165ecd24697ef06c87a0fb.camel@kernel.org>
In-Reply-To: <c7d649582724d8f2fd165ecd24697ef06c87a0fb.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6640:EE_
x-ms-office365-filtering-correlation-id: 0da150a3-361d-4b4e-da45-08dab1db362f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwfAS+kUZCaw+Ox7+9R2BGm8S+9IFRUH7x9tREqJVfUj9kGRRDlnZIokiKiEhzCn4HrfuppXdjn3hPhc3b2sW9oRJeqKC5Fvpb9r//CHkg0ML0RT9Y/rDyZ+MJ5oceW5NJ2/w5XI3YihBIRX5ze6ggxt1CbawKfrnPXw9OC+g6kcPk4r2V1LLe5ih0z0tkLL/8IEcUVXjngPPfyqkCZ8qto0wL/Zmia379Dx6wjj5eIVkSs9HUfYQMg8JhS/SH/Bhc3WGfS5oAviNbZvPRAMdToTC3PBjtOxUSsGAz1Sglv5GEA1rYuecP7NFMwHTl2/gMYz7oSuDdHbj2lmUWmtcfzfrUH+vgZkQ3c7B/JsBqIDUpIWIcW+BY67voB7R5GGXpBbEm57bpN4tOBUjzWkk1hGCjvXCWr3K+XSP3gsxaukuE+0ePWRQWrfjJvSRtvpsn7WMD3P/SdLtbXGAcSJxQlbznE3wEEfXAKP2bUp0uKaVGMeXGRTd0SaXeTVjeZtdRZ4YNYZdml6LoPhhGoasgWGltLJcQdb1gj7woUlrsy/gm/aOKMYy6OXj3iluqrg+r6jFUl86EJ9gbYMN8cWxi5TDkUk/d4Tx4bErhcqEiiHCgweA2FKg2ysX7pJ1Mt6xuMUT3eY6JJ0oMudQAtps8OSti31O61AGoo4B9XJqo++eKYeT/X4LpGxninXLwtgK5hNbqf7bOG6KGVKi+PxJCf960Ssd4jDDgtsQLkgwOy/Bh6FMgyu4VRDaeBqBArSETa/LaBMCgwZJudu0w68Od10v+WbukeqTIOoqmeMctVN452OiJU3NxyOb4v/zmAPEo84uG6kcrk4jJpR9gkOdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(66946007)(8676002)(5660300002)(4001150100001)(30864003)(66446008)(54906003)(66476007)(64756008)(316002)(478600001)(53546011)(41300700001)(6512007)(26005)(2906002)(71200400001)(6486002)(8936002)(966005)(4326008)(2616005)(186003)(6506007)(6916009)(38070700005)(36756003)(66556008)(83380400001)(38100700002)(91956017)(122000001)(33656002)(86362001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dJLV4Yh568TiG0qHlmB/ByQPq3JiKSMZQVJ+fi3EL1Kw91GYaY4Js9PbnfGE?=
 =?us-ascii?Q?8WwRVxTrfoK9YIHUpsCGUctk74pXrLjzhIe5VtcbJ0RcVyEiuEijhS+cVSWz?=
 =?us-ascii?Q?47bThyDtReDh+4K1owYZTftFIvkQ5zzkRUljtWtO4P1HMbqMb6T3nUAViY65?=
 =?us-ascii?Q?KY4CtiftATWYisNolh7nCR3kRj6stT8uT9RzNVIRuDFTAT/a8AJ0UcQC0So+?=
 =?us-ascii?Q?+d2KgGOlHXrpx7dkMXAc/RA3cqo+lMMcccnmMJMbrNw1k2ELRI98OyHCusfQ?=
 =?us-ascii?Q?4h0kNz9WdqWPxX1mS2bKd5heRWNVYvmj1aJHp7UTGxw1X/CQkrDjgwOUd7eU?=
 =?us-ascii?Q?DBBO1WBw1n+50Tj+c+3VCmXuNx855MNVXm7iJj8J/Np2KEZRT6SF5qqE9ttc?=
 =?us-ascii?Q?GsgYHXLkNpclZwP31jQZNNar+NP3asVPtLhBtqMuafjM53FxUBkK1OvLJ5zu?=
 =?us-ascii?Q?r7JU9H0mCXnmw+zp0FHtYs/Q+mi7RByRhMBqp3n4El9NEdu3yAtmHH6QIiyD?=
 =?us-ascii?Q?1pyGQGKDDO9AJuWRVdeDMfu0sb7JntwtNjYLujCmInsrmNcbOhE74VnUwgVf?=
 =?us-ascii?Q?CaWbDPfTjUsRsHDM5xOEypndvQqIJ5OQeWqXIMP7s2fqw9dLn6ogJbNWTNNt?=
 =?us-ascii?Q?5JdvC8eyDpYzX5x8kEXobzC/QwJ8Owec8bUTJz2t7dCVYy8mO4YEh4wIZkiS?=
 =?us-ascii?Q?XWgf13xamKDgJ9lhFYL+m6qx16YmxF1BZww0DtyE2iU7WU/tDm5fZ0NNKA3r?=
 =?us-ascii?Q?IgX8bm7fSb/2BL6ycKcdRpSNUOwnQsDpUsivpayM7GRdo7nDmIkp9P5KTCtI?=
 =?us-ascii?Q?AjPPQbEXEyAa950qlBzRhA60wHkjz5Ww/fktevb6b2E6G82ljjg89m8Dx02R?=
 =?us-ascii?Q?7yMNvTYqgZT4I1IW+A978AYAlj9vxRIwH8tF9yvVhjg5Om1jnkqGN+ot9Oeb?=
 =?us-ascii?Q?XD5Lmlw3Uk49KpU2etEe+tKvsctcBcKrRM51jIdBpeqWGFKD0b+N7+R5vDUh?=
 =?us-ascii?Q?yhvOhzGF5ltrJhucJBKu0U0qR9f7CyWaKLcS5Bf6u3eaXVrTcezsT/camgqD?=
 =?us-ascii?Q?bMW/6G39hfzEy6Pd9dFAE52dWjlVSs9dw4FVMN4LVTI8L8Pnjy04Uc7g61iy?=
 =?us-ascii?Q?VxuZ4omzuG7lD6juuz4reOnk4SHvTV3Qef1ciYYiamU1aRy18lVrtKFQ91OZ?=
 =?us-ascii?Q?HB8BIwMZBgK5hDCYifLszKIXSZKsJBh3c50Bl9MRRtBw/q6NbzblxFrT5/Yj?=
 =?us-ascii?Q?49BgF15aLb4ElS2O2+hPfmhpA69gvClrWjdpy6OclLXeByL4YFneQVOuti/U?=
 =?us-ascii?Q?E/I+t3UuXfXqmJbIUsqhFpZUQSXMAK+ZTYqLCFOgSi3M8IKoN5Nuu+MYEy1h?=
 =?us-ascii?Q?M/V2j7RUjHkdy7gKsA3mH6co7EeRhnY01YDT1V3ua4WdKQouXsl7Odb/MkgB?=
 =?us-ascii?Q?gKjKHdwmB6cysRMYJBOzPviOYlloUUiu+OYpoEwPUeXwmD5kWKsyX9ZwmwJw?=
 =?us-ascii?Q?NSSukLmPdYmUT3I3eef3YMMMKdAaiU56E3c5dDgQqkQUzHjSeSPJrUXbdIVg?=
 =?us-ascii?Q?rwh7dIF/H/mXGVat2BXZE8SqEQi9kpPsofzTi1l5hzxDqg/ZzYQtvOHT6Kfr?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84EFAB14AEAD934892CB7736B792F373@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da150a3-361d-4b4e-da45-08dab1db362f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 14:07:09.0781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq9pJhIVyODyyOcmvoBOKaUgWaxDaSF0pIUvGk8IxPhMEkOs7gBzDrPMTRZZs2EjiIDaPeaHQ9hkAVc4xnd8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190079
X-Proofpoint-ORIG-GUID: eKHvlNaaxr9e0jSP9vQKi396HRVncs01
X-Proofpoint-GUID: eKHvlNaaxr9e0jSP9vQKi396HRVncs01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 19, 2022, at 7:24 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-10-18 at 15:58 -0400, Chuck Lever wrote:
>> NFSv4 operations manage the lifetime of nfsd_file items they use by
>> means of NFSv4 OPEN and CLOSE. Hence there's no need for them to be
>> garbage collected.
>>=20
>> Introduce a mechanism to enable garbage collection for nfsd_file
>> items used only by NFSv2/3 callers.
>>=20
>> Note that the change in nfsd_file_put() ensures that both CLOSE and
>> DELEGRETURN will actually close out and free an nfsd_file on last
>> reference of a non-garbage-collected file.
>>=20
>> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D394
>> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Tested-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/filecache.c |   61 +++++++++++++++++++++++++++++++++++++++++++++=
------
>> fs/nfsd/filecache.h |    3 +++
>> fs/nfsd/nfs3proc.c  |    4 ++-
>> fs/nfsd/trace.h     |    3 ++-
>> fs/nfsd/vfs.c       |    4 ++-
>> 5 files changed, 63 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index b7aa523c2010..87fce5c95726 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -63,6 +63,7 @@ struct nfsd_file_lookup_key {
>> 	struct net			*net;
>> 	const struct cred		*cred;
>> 	unsigned char			need;
>> +	unsigned char			gc:1;
>=20
> Is it worth it to mess around with bitfields here? There are exising
> holes in this struct, so you're really not saving anything by using one
> here.
>=20
> Also, it seems like "need" is used as a bool anyway.

AFAICS, @need is a set of NFSD_MAY flags, not a bool.


> Maybe both of those
> fields should just be bools? It looks like changing that won't change
> the size of the struct anyway. You might even be able to shrink it by
> moving the "type" above "need".

I forgot to check this with pahole. I assumed the compiler would
squeeze these fields into a single 32-bit word, but in fact it
does not do that.

But, I don't think there's any arrangement of these fields that
avoids a hole. We can revisit if more fields are added to the
lookup key struct.


>> 	enum nfsd_file_lookup_type	type;
>> };
>>=20
>> @@ -162,6 +163,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_com=
pare_arg *arg,
>> 			return 1;
>> 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
>> 			return 1;
>> +		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) !=3D key->gc)
>> +			return 1;
>> 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0)
>> 			return 1;
>> 		break;
>> @@ -297,6 +300,8 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, un=
signed int may)
>> 		nf->nf_flags =3D 0;
>> 		__set_bit(NFSD_FILE_HASHED, &nf->nf_flags);
>> 		__set_bit(NFSD_FILE_PENDING, &nf->nf_flags);
>> +		if (key->gc)
>> +			__set_bit(NFSD_FILE_GC, &nf->nf_flags);
>> 		nf->nf_inode =3D key->inode;
>> 		/* nf_ref is pre-incremented for hash table */
>> 		refcount_set(&nf->nf_ref, 2);
>> @@ -428,16 +433,27 @@ nfsd_file_put_noref(struct nfsd_file *nf)
>> 	}
>> }
>>=20
>> +static void
>> +nfsd_file_unhash_and_put(struct nfsd_file *nf)
>> +{
>> +	if (nfsd_file_unhash(nf))
>> +		nfsd_file_put_noref(nf);
>> +}
>> +
>> void
>> nfsd_file_put(struct nfsd_file *nf)
>> {
>> 	might_sleep();
>>=20
>> -	nfsd_file_lru_add(nf);
>> +	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 1)
>> +		nfsd_file_lru_add(nf);
>> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
>> +		nfsd_file_unhash_and_put(nf);
>> +
>> 	if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) =3D=3D 0) {
>> 		nfsd_file_flush(nf);
>> 		nfsd_file_put_noref(nf);
>> -	} else if (nf->nf_file) {
>> +	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D=
 1) {
>> 		nfsd_file_put_noref(nf);
>> 		nfsd_file_schedule_laundrette();
>> 	} else
>> @@ -1017,12 +1033,14 @@ nfsd_file_is_cached(struct inode *inode)
>>=20
>> static __be32
>> nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> -		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
>> +		     unsigned int may_flags, struct nfsd_file **pnf,
>> +		     bool open, int want_gc)
>> {
>> 	struct nfsd_file_lookup_key key =3D {
>> 		.type	=3D NFSD_FILE_KEY_FULL,
>> 		.need	=3D may_flags & NFSD_FILE_MAY_MASK,
>> 		.net	=3D SVC_NET(rqstp),
>> +		.gc	=3D want_gc,
>> 	};
>> 	bool open_retry =3D true;
>> 	struct nfsd_file *nf;
>> @@ -1117,14 +1135,35 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
>> 	 * then unhash.
>> 	 */
>> 	if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>> -		if (nfsd_file_unhash(nf))
>> -			nfsd_file_put_noref(nf);
>> +		nfsd_file_unhash_and_put(nf);
>> 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>> 	smp_mb__after_atomic();
>> 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>> 	goto out;
>> }
>>=20
>> +/**
>> + * nfsd_file_acquire_gc - Get a struct nfsd_file with an open file
>> + * @rqstp: the RPC transaction being executed
>> + * @fhp: the NFS filehandle of the file to be opened
>> + * @may_flags: NFSD_MAY_ settings for the file
>> + * @pnf: OUT: new or found "struct nfsd_file" object
>> + *
>> + * The nfsd_file object returned by this API is reference-counted
>> + * and garbage-collected. The object is retained for a few
>> + * seconds after the final nfsd_file_put() in case the caller
>> + * wants to re-use it.
>> + *
>> + * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>> + * network byte order is returned.
>> + */
>> +__be32
>> +nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		     unsigned int may_flags, struct nfsd_file **pnf)
>> +{
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 1);
>> +}
>> +
>> /**
>>  * nfsd_file_acquire - Get a struct nfsd_file with an open file
>>  * @rqstp: the RPC transaction being executed
>> @@ -1132,6 +1171,10 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>>  * @may_flags: NFSD_MAY_ settings for the file
>>  * @pnf: OUT: new or found "struct nfsd_file" object
>>  *
>> + * The nfsd_file_object returned by this API is reference-counted
>> + * but not garbage-collected. The object is unhashed after the
>> + * final nfsd_file_put().
>> + *
>>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>>  * network byte order is returned.
>>  */
>> @@ -1139,7 +1182,7 @@ __be32
>> nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, true, 0);
>> }
>>=20
>> /**
>> @@ -1149,6 +1192,10 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
>>  * @may_flags: NFSD_MAY_ settings for the file
>>  * @pnf: OUT: new or found "struct nfsd_file" object
>>  *
>> + * The nfsd_file_object returned by this API is reference-counted
>> + * but not garbage-collected. The object is released immediately
>> + * one RCU grace period after the final nfsd_file_put().
>> + *
>>  * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
>>  * network byte order is returned.
>>  */
>> @@ -1156,7 +1203,7 @@ __be32
>> nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		 unsigned int may_flags, struct nfsd_file **pnf)
>> {
>> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false);
>> +	return nfsd_file_do_acquire(rqstp, fhp, may_flags, pnf, false, 0);
>> }
>>=20
>> /*
>> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
>> index f81c198f4ed6..0f6546bcd3e0 100644
>> --- a/fs/nfsd/filecache.h
>> +++ b/fs/nfsd/filecache.h
>> @@ -38,6 +38,7 @@ struct nfsd_file {
>> #define NFSD_FILE_HASHED	(0)
>> #define NFSD_FILE_PENDING	(1)
>> #define NFSD_FILE_REFERENCED	(2)
>> +#define NFSD_FILE_GC		(3)
>> 	unsigned long		nf_flags;
>> 	struct inode		*nf_inode;	/* don't deref */
>> 	refcount_t		nf_ref;
>> @@ -55,6 +56,8 @@ void nfsd_file_put(struct nfsd_file *nf);
>> struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>> void nfsd_file_close_inode_sync(struct inode *inode);
>> bool nfsd_file_is_cached(struct inode *inode);
>> +__be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> 		  unsigned int may_flags, struct nfsd_file **nfp);
>> __be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index d12823371857..6a5ad6c91d8e 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -779,8 +779,8 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>> 				(unsigned long long) argp->offset);
>>=20
>> 	fh_copy(&resp->fh, &argp->fh);
>> -	resp->status =3D nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
>> -					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> +	resp->status =3D nfsd_file_acquire_gc(rqstp, &resp->fh, NFSD_MAY_WRITE=
 |
>> +					    NFSD_MAY_NOT_BREAK_LEASE, &nf);
>> 	if (resp->status)
>> 		goto out;
>> 	resp->status =3D nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 9ebd67d461f9..4921144880d3 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -742,7 +742,8 @@ DEFINE_CLID_EVENT(confirmed_r);
>> 	__print_flags(val, "|",						\
>> 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
>> 		{ 1 << NFSD_FILE_PENDING,	"PENDING" },		\
>> -		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"})
>> +		{ 1 << NFSD_FILE_REFERENCED,	"REFERENCED"},		\
>> +		{ 1 << NFSD_FILE_GC,		"GC"})
>>=20
>> DECLARE_EVENT_CLASS(nfsd_file_class,
>> 	TP_PROTO(struct nfsd_file *nf),
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 44f210ba17cc..89d682a56fc4 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1060,7 +1060,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>> 	__be32 err;
>>=20
>> 	trace_nfsd_read_start(rqstp, fhp, offset, *count);
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
>> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_READ, &nf);
>> 	if (err)
>> 		return err;
>>=20
>> @@ -1092,7 +1092,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *=
fhp, loff_t offset,
>>=20
>> 	trace_nfsd_write_start(rqstp, fhp, offset, *cnt);
>>=20
>> -	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>> +	err =3D nfsd_file_acquire_gc(rqstp, fhp, NFSD_MAY_WRITE, &nf);
>> 	if (err)
>> 		goto out;
>>=20
>>=20
>>=20
>=20
> Patch itself looks fine though. You can add:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> ...but I'd probably prefer to see the flags in that struct as bools
> instead if you're amenable to the change.

--
Chuck Lever



