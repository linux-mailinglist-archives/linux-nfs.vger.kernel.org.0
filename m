Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8565F002
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 16:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjAEPX4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 10:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjAEPXk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 10:23:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9450E4F
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 07:23:38 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3pGI010590;
        Thu, 5 Jan 2023 15:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YpUMWAXb82MOAhqEWEA7uKTPJmwpkPe+wl9RoHMeDp4=;
 b=L2UBiZrwd4SUzWUssBm9HrFb8Dgxa7rZAgDOCHLvTSzZXqj5fHzRxbIkdm73kA9ikAIC
 yLCmVpyGm6XdwpSNoXNA2xYbmoldohuTRfihS+slI1OYh06VkPqux+cZtnZHnPBWaK+Z
 5ByfiHfc3LnW3/aXxrboHEPkWs+v3+vrpp3AbNo9itot1kZzG3CqKTk+2NXlX3DswyEL
 1kTt1buRthe+8kLHus9K9ooQ0q+bS5V5pPw50BktqaqzQ1INiwzyULAPfx+MnF2JuZpr
 JDwQbJjoc6IBzRO48uRp3EOr09iGi6hJYeY2buDxiJjPVmt8H09TmlyFG6P8BWQYiDCr Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv313e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:23:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPLs4034000;
        Thu, 5 Jan 2023 15:23:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdts8qxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 15:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPjgVEuGEzLPULn01h41rl4OdrI3oNmjyRH2iKsq/FpDVnralWGXZb/dmQZaKlQt09bty1ogabQQaPtkoccSsW+sOOiEVQHbf+Fz0FH/X04NmUlxGrNou2c/2ij8712O6u5Zaao0ryfoYRiknDjzMkGvsLo3pM7RxpvhKbxbrLbWJ3cULzu7Mc9oTV21XgvXdobzHK0zEQdwk+Su2LuFD/8uLHIZsRClxjcYAr8drntjZ2FYoVA5/AyHdEe3SJ1eDlPzngRMhUt14CEUo4HzRGdmiOB7wc/G5lsKV45dIy/+OfhPUQc/wl3Gxft9Ami28+BapmmlHMNe5ox6A25h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpUMWAXb82MOAhqEWEA7uKTPJmwpkPe+wl9RoHMeDp4=;
 b=DLGpMWa3fjBEyi7NBCXD1fApstBXAE8owASRnAqr6ZTbkYxdikpGowWtciX+wfedwYrbjpSMpOuvnozLD3z1qxxoyvIs9xjkzl3ex11C6nL8LMPLwQCFkei+hIkgI4xiKLU2uDsY6j++9nJSxE+OVd0Y8XUFJ4kv7H52wevxG0Qf0XqswsjyPR78la4Fe9mCf943lOC+DQj5275L+jkflz4laSLy3GsLAXmn3UcF13MvUVNd97He/vVQ9tkl4J39dfgjNXF6TMXkpDHOlB/ACE3T8Nu2YGUgnDGA76uD62gKQmG9k7w8yA+RoKcL0t3EGezqf6mFxY8LAkXh/4I95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpUMWAXb82MOAhqEWEA7uKTPJmwpkPe+wl9RoHMeDp4=;
 b=UqtJ2S/bvskbQOwKglnPQfiLAq7oAsi2tk6zx4jsr0xoT2Yn3c5fXMnwPPuQs+grLL+cJxV9qFydpb9zrgpxPi680BDPLechf7L2CbVSm67sNFIvMrWN4tixhX3/ITHtLlI6wZ9UDPm3jU8MDh1LcxR/QEBjZ1jmS++g1sf8aGA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:23:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:23:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Thread-Topic: [PATCH v2 1/1] NFSD: enhance inter-server copy cleanup
Thread-Index: AQHZE0St34jtf1Ze5Ey5ptczv+ym966M9LkAgAMYEYA=
Date:   Thu, 5 Jan 2023 15:23:30 +0000
Message-ID: <4CD4E6BD-9399-468C-93C4-D6FB455C446B@oracle.com>
References: <1671411353-31165-1-git-send-email-dai.ngo@oracle.com>
 <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com>
In-Reply-To: <28572446-B32A-461F-A9C1-E60F79B985D3@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB5947:EE_
x-ms-office365-filtering-correlation-id: 1f3d874e-e348-4692-ae38-08daef30ccfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wD0E1a/SJlBVZTzECcy7wo0Rn6FzhLAUdYP4Sc0jRRxoIXv1sgH5oCcwEIOEcPjwAnIDF7W7HKItcT/J6n3M5uic5cRdABqQpsnp+E+ZWA+ZYN49aU+nrOWLYMo1j9NrzqF9AylYxZETSmshBIE5anK4vfKydLGjalPDrIlrH/nmMxTuZqwZJ9AxkSqeE2XDalDLuQrq5vqhLvroN4q4LhRQf6h6aV90qH61Ms2XXZumv+gEpTtLlo5OCCt2ILzDuQ69z2meW3olEItxtaLnRflT2lU//smSrISExQMwGh3hy988cAuqNFFZoSygltlSlstC1BaMW5lur/LKpa8u5czTdFtnwTboMHmCoKCggTOVvkpdcFNIy/O//pcuR2dNK/zebNwKtlhfUdEnOC93UMBoQifUBZxV6X4284AvWSF202nA/4bz5bKeglobbmRsF1KcZ798JX4Gt+4vyZyZkvGdqCGR6Ud2ZpKYiXGjC3FLtCYBPzfECjf0on2IVQ6pA1MzbJyQTdt+n/4ZPo9G5WJtMg3RaCtyapEyzNj+3OuaE9V7j+4dmMcGXe5UaF9I+sc7Wlwiri8F5ZEKj0zx8XbZiW76r6jMcu5z5YE3ht1AnVEvRqQY2rH3OSf6FyXgovAmk2FgcJ6yDCa4RpgW7jyEEM27tvK4MduK3Ew+mIIjYA1NtmQ1C5bw+7B4xvFkAwM3uWjEtIQDwmdo1cU2XgdfN6OTwfK17DJZCxPeEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(54906003)(6636002)(316002)(38100700002)(37006003)(6512007)(33656002)(8936002)(41300700001)(76116006)(186003)(66946007)(36756003)(66556008)(8676002)(4326008)(66476007)(6862004)(53546011)(86362001)(38070700005)(83380400001)(478600001)(6486002)(2616005)(91956017)(71200400001)(66446008)(64756008)(6506007)(26005)(122000001)(2906002)(30864003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ej1Vvzo3y7ZBhZ7ApjqVpNzSxyvwNbrIasz9kCBOLWZabfl3BDxgTUiIErit?=
 =?us-ascii?Q?VJoaRb+j499srhqc0zeigspxs4CzaQ/w/NwunWGKLuitFk6GFQnf43jKHR8a?=
 =?us-ascii?Q?VfC/2NIlrp6bvg29PIfxcuUEIAxwVHVjcfkXxoJUriHZYV2zoRrMNdLx4B3z?=
 =?us-ascii?Q?4gMl30DAbI9IWpyPwkQkjQkd9KHMCqmI9R8S4Z+I+PN1vOFBX25x5Mt4PUA/?=
 =?us-ascii?Q?a6UNv6ERbXXYid+NSjlV8pSuDyIlYF1TMN9EU+MbjE+S+mim9GHf2OX60e6a?=
 =?us-ascii?Q?xV+AP1AtLXQctny3F7OeJ3xYaTLL4ovnw/BkuAm1Bw80jgSqe4dEIz4WF+Sm?=
 =?us-ascii?Q?NQQubLrPcnsDSmZa6SPBNuEO4pE+Myf0EJbB4rU5DswkQ/cUVCVOcLaTqr9/?=
 =?us-ascii?Q?2gDySjUbBGmekVx3NNTulZCoscF9B0eQ2H4KyEhkpk+WYPQN3taYtkuiNsi1?=
 =?us-ascii?Q?ZYvcuoh9liY5XHHVhlvYmDUot9ZjuR1t3rCnCn47EqmedeJZM5efbiQoOooo?=
 =?us-ascii?Q?juNq8uUhCe9HoLtl4f8TfEO8XNlu27CRCKjc+nbeDtDzDfz20dTdU2ob1aFz?=
 =?us-ascii?Q?ioM1aFtXzTdl9Pmen4dEqpErIYEh9AUqzJWNjo55DmkFZCurRZUveyr+AfZ4?=
 =?us-ascii?Q?v1RqI8JNLl9ssUqzOk6tubK2DCuQeSJBhgHiIAgGYRpxUnUBJRDGwbNZ1MEs?=
 =?us-ascii?Q?IuDK5Ars9pWpThF0XL77pvE3A9mhZgO5lFQ1p5ZCnEM8KNxkUIqtycJgosEu?=
 =?us-ascii?Q?lSg9DTHwFMQPa34HSWmSkuTZYUQWatUhlE0v4Ii0+p0l/LT5cHxAnmqFp7th?=
 =?us-ascii?Q?jqvsOFlKB2veuyAbQ79BCX3MRKyk4uFdNuyKJSJThNkdFfgN7FyeL1bEyN9E?=
 =?us-ascii?Q?4Q+PKBSd56qxX7F6oXZs7z7cnrcs1S6Hrs5/m9jxpH0NIYKddxZj8pn7hb6e?=
 =?us-ascii?Q?Tg8KTk1KFMF0SQUb1VTAOhN7W3aW5BXflxH/8TimNbmJ3panN9d7AR1Wh5F7?=
 =?us-ascii?Q?egwvNWriYoULTEb9ReidoWN7/FJpK/+FObtPQyvyz9ZvtmXd4n5EBHlBRj0K?=
 =?us-ascii?Q?JWUtkXpZpTRXCYhNDfr5j8hRCAIczjQc5Xq0NCc8s/Tp94fpbAXIjUlDFcif?=
 =?us-ascii?Q?3dyA99spjbC/09MUxglWTR4SvMWsXp8ZmotpdEAOW0XYkzVsu/kx4vKSKSNl?=
 =?us-ascii?Q?A/b5PUI57Gwn2n9Vl6YHpfSKdgxDnsZYnbe/PFP3z+Rtq/znUUxTGaAPgepc?=
 =?us-ascii?Q?DpxyP38etj9neAeoEpizObdhNPlKjyjeiBjQ2wMpOJAZbZnaXWKgxShMtIv7?=
 =?us-ascii?Q?Ob3tc/6n40r8qZ4F4sIKIPS4DfJEppFxzIPbmf1QZKo+7VTX+mrciqew2jI/?=
 =?us-ascii?Q?clDElR4OIeETaykiU9Bj+oNyBhmc5kC15eivic9kYd0auOGjfDe/evx7n/R6?=
 =?us-ascii?Q?wZgDQi8lMexkfZGe3QAYMIoJ1h10cDbqryAKB/IZUsj587J4C20o39ReK9R2?=
 =?us-ascii?Q?LlOaUHQm/2uWcw58LbBiBhoLCqyCWS38gj7rC+jx5b7b7JgoFzTHZcyGT9PI?=
 =?us-ascii?Q?D1U9G0pLNWo0VFpA9UUy5XEVLDY5igmlKWmHjAB41lVNZsquGsfU2KpPZCIK?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15EA785B647DA24BA22B475A2316E519@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 227+7sFRe36wSiT2QYlQl+m1wskjfyTHPyXmZF5yV5bQw06/7JREVonkhLpPWsG7Z2wJn192NVr8mvXY6WOhXXn0Qxq89U5DtCqLNOAKmCl3fyta4xp7ItfIqc4oEdsuqb14hnAH0Q13aMv7sYvNwTwGhTEA1cWeIW7sNaSXCLmR8mpUyCIM2te1/fkQPiPU07nfMcPlcqU0OdkBr8szEQOEUtNNGGhqJj2PMCWk0wbj7bFL4Na6fWzl8CTxR0iJCmN2Mcgwf1U6nvf0uJtJ0QJJZPf9PsbOZHZJuVJ0UJzXHAbYjobkDONh7pHz543gleOYNbJTQedknWimVU1E4vslxNsxWkaIFbsjghcYlNs9AnrQnhwW75SuuCBMROiHpgUIlhBSQeghqVJjgVMj6F51jDQXxIZ7JSv50HeQ1EiZYhvilQmDtWrb8CleRu7YrPb4wLcZk6RwtZvq90rnvusBFn/JQ7Czdbp5ocNOVHr9QP9DLiRVFVWnRRrkZF7Vq5QkZux6a6qUrMaw656w+hXAvCD2ygMMbV80WEGF8CY6Lax/DaXH/sWu+FBRXPRvYH8IUD14geN4yvgorgHortaIGijd3xBkqYH4z+z1EqkY0WQ8SKcRwDxFpEcGHCNPBkH5soW+0PZiQji4OShRJ3GRuSSqLjLIG5+df9xlh/NWQJj19Mf9sPdeyN07xnaN4W1oc7METP2pbw3YsJ3KM71+Jr4RMDraOlMGigEMUvbZkwPrnW38a0TAkh75k5wOAhJAbMJZURYDIIz+Rw2IiDLo3bfyMS4QKoFgrMaYAVd/sx5m9/8DSLm+HC2tXIyV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3d874e-e348-4692-ae38-08daef30ccfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 15:23:30.2367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrJzpCIaZrxlTB7cGGeNjOdWpbfr7N9cEUCmY7Ra6ipjy8+2hiBiV5xePSMLwZhZCCEqlS8VQ1OOi8LTI+ZuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050121
X-Proofpoint-GUID: 5pQVFMPpju3DpxIOHt2POJ4b5DBjJ3h_
X-Proofpoint-ORIG-GUID: 5pQVFMPpju3DpxIOHt2POJ4b5DBjJ3h_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 3, 2023, at 11:08 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Dec 18, 2022, at 7:55 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>=20
>> Currently nfsd4_setup_inter_ssc returns the vfsmount of the source
>> server's export when the mount completes. After the copy is done
>> nfsd4_cleanup_inter_ssc is called with the vfsmount of the source
>> server and it searches nfsd_ssc_mount_list for a matching entry
>> to do the clean up.
>>=20
>> The problems with this approach are (1) the need to search the
>> nfsd_ssc_mount_list and (2) the code has to handle the case where
>> the matching entry is not found which looks ugly.
>>=20
>> The enhancement is instead of nfsd4_setup_inter_ssc returning the
>> vfsmount, it returns the nfsd4_ssc_umount_item which has the
>> vfsmount embedded in it. When nfsd4_cleanup_inter_ssc is called
>> it's passed with the nfsd4_ssc_umount_item directly to do the
>> clean up so no searching is needed and there is no need to handle
>> the 'not found' case.
>>=20
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> V2: fix compile error when CONFIG_NFSD_V4_2_INTER_SSC not defined.
>>   Reported by kernel test robot.
>=20
> Hello Dai - I've looked at this, nothing to comment on so far. I
> plan to go over it again sometime this week.
>=20
> I'd like to hear from others before applying it.

Applied to nfsd's for-next.


>> fs/nfsd/nfs4proc.c      | 94 +++++++++++++++++++------------------------=
------
>> fs/nfsd/xdr4.h          |  2 +-
>> include/linux/nfs_ssc.h |  2 +-
>> 3 files changed, 38 insertions(+), 60 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index b79ee65ae016..6515b00520bc 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1295,15 +1295,15 @@ extern void nfs_sb_deactive(struct super_block *=
sb);
>> * setup a work entry in the ssc delayed unmount list.
>> */
>> static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
>> -		struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
>> +		struct nfsd4_ssc_umount_item **nsui)
>> {
>> 	struct nfsd4_ssc_umount_item *ni =3D NULL;
>> 	struct nfsd4_ssc_umount_item *work =3D NULL;
>> 	struct nfsd4_ssc_umount_item *tmp;
>> 	DEFINE_WAIT(wait);
>> +	__be32 status =3D 0;
>>=20
>> -	*ss_mnt =3D NULL;
>> -	*retwork =3D NULL;
>> +	*nsui =3D NULL;
>> 	work =3D kzalloc(sizeof(*work), GFP_KERNEL);
>> try_again:
>> 	spin_lock(&nn->nfsd_ssc_lock);
>> @@ -1326,12 +1326,12 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_ne=
t *nn, char *ipaddr,
>> 			finish_wait(&nn->nfsd_ssc_waitq, &wait);
>> 			goto try_again;
>> 		}
>> -		*ss_mnt =3D ni->nsui_vfsmount;
>> +		*nsui =3D ni;
>> 		refcount_inc(&ni->nsui_refcnt);
>> 		spin_unlock(&nn->nfsd_ssc_lock);
>> 		kfree(work);
>>=20
>> -		/* return vfsmount in ss_mnt */
>> +		/* return vfsmount in (*nsui)->nsui_vfsmount */
>> 		return 0;
>> 	}
>> 	if (work) {
>> @@ -1339,10 +1339,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_ne=
t *nn, char *ipaddr,
>> 		refcount_set(&work->nsui_refcnt, 2);
>> 		work->nsui_busy =3D true;
>> 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
>> -		*retwork =3D work;
>> -	}
>> +		*nsui =3D work;
>> +	} else
>> +		status =3D nfserr_resource;
>> 	spin_unlock(&nn->nfsd_ssc_lock);
>> -	return 0;
>> +	return status;
>> }
>>=20
>> static void nfsd4_ssc_update_dul_work(struct nfsd_net *nn,
>> @@ -1371,7 +1372,7 @@ static void nfsd4_ssc_cancel_dul_work(struct nfsd_=
net *nn,
>> */
>> static __be32
>> nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>> -		       struct vfsmount **mount)
>> +			struct nfsd4_ssc_umount_item **nsui)
>> {
>> 	struct file_system_type *type;
>> 	struct vfsmount *ss_mnt;
>> @@ -1382,7 +1383,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, str=
uct svc_rqst *rqstp,
>> 	char *ipaddr, *dev_name, *raw_data;
>> 	int len, raw_len;
>> 	__be32 status =3D nfserr_inval;
>> -	struct nfsd4_ssc_umount_item *work =3D NULL;
>> 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>>=20
>> 	naddr =3D &nss->u.nl4_addr;
>> @@ -1390,6 +1390,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, str=
uct svc_rqst *rqstp,
>> 					 naddr->addr_len,
>> 					 (struct sockaddr *)&tmp_addr,
>> 					 sizeof(tmp_addr));
>> +	*nsui =3D NULL;
>> 	if (tmp_addrlen =3D=3D 0)
>> 		goto out_err;
>>=20
>> @@ -1432,10 +1433,10 @@ nfsd4_interssc_connect(struct nl4_server *nss, s=
truct svc_rqst *rqstp,
>> 		goto out_free_rawdata;
>> 	snprintf(dev_name, len + 5, "%s%s%s:/", startsep, ipaddr, endsep);
>>=20
>> -	status =3D nfsd4_ssc_setup_dul(nn, ipaddr, &work, &ss_mnt);
>> +	status =3D nfsd4_ssc_setup_dul(nn, ipaddr, nsui);
>> 	if (status)
>> 		goto out_free_devname;
>> -	if (ss_mnt)
>> +	if ((*nsui)->nsui_vfsmount)
>> 		goto out_done;
>>=20
>> 	/* Use an 'internal' mount: SB_KERNMOUNT -> MNT_INTERNAL */
>> @@ -1443,15 +1444,12 @@ nfsd4_interssc_connect(struct nl4_server *nss, s=
truct svc_rqst *rqstp,
>> 	module_put(type->owner);
>> 	if (IS_ERR(ss_mnt)) {
>> 		status =3D nfserr_nodev;
>> -		if (work)
>> -			nfsd4_ssc_cancel_dul_work(nn, work);
>> +		nfsd4_ssc_cancel_dul_work(nn, *nsui);
>> 		goto out_free_devname;
>> 	}
>> -	if (work)
>> -		nfsd4_ssc_update_dul_work(nn, work, ss_mnt);
>> +	nfsd4_ssc_update_dul_work(nn, *nsui, ss_mnt);
>> out_done:
>> 	status =3D 0;
>> -	*mount =3D ss_mnt;
>>=20
>> out_free_devname:
>> 	kfree(dev_name);
>> @@ -1474,8 +1472,7 @@ nfsd4_interssc_connect(struct nl4_server *nss, str=
uct svc_rqst *rqstp,
>> */
>> static __be32
>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>> -		      struct nfsd4_compound_state *cstate,
>> -		      struct nfsd4_copy *copy, struct vfsmount **mount)
>> +		struct nfsd4_compound_state *cstate, struct nfsd4_copy *copy)
>> {
>> 	struct svc_fh *s_fh =3D NULL;
>> 	stateid_t *s_stid =3D &copy->cp_src_stateid;
>> @@ -1488,7 +1485,8 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>> 	if (status)
>> 		goto out;
>>=20
>> -	status =3D nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
>> +	status =3D nfsd4_interssc_connect(copy->cp_src, rqstp,
>> +				&copy->ss_nsui);
>> 	if (status)
>> 		goto out;
>>=20
>> @@ -1506,61 +1504,42 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>> }
>>=20
>> static void
>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *=
filp,
>> 			struct nfsd_file *dst)
>> {
>> -	bool found =3D false;
>> 	long timeout;
>> -	struct nfsd4_ssc_umount_item *tmp;
>> -	struct nfsd4_ssc_umount_item *ni =3D NULL;
>> 	struct nfsd_net *nn =3D net_generic(dst->nf_net, nfsd_net_id);
>>=20
>> 	nfs42_ssc_close(filp);
>> 	nfsd_file_put(dst);
>> 	fput(filp);
>>=20
>> -	if (!nn) {
>> -		mntput(ss_mnt);
>> -		return;
>> -	}
>> 	spin_lock(&nn->nfsd_ssc_lock);
>> 	timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>> -	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list)=
 {
>> -		if (ni->nsui_vfsmount->mnt_sb =3D=3D ss_mnt->mnt_sb) {
>> -			list_del(&ni->nsui_list);
>> -			/*
>> -			 * vfsmount can be shared by multiple exports,
>> -			 * decrement refcnt. If the count drops to 1 it
>> -			 * will be unmounted when nsui_expire expires.
>> -			 */
>> -			refcount_dec(&ni->nsui_refcnt);
>> -			ni->nsui_expire =3D jiffies + timeout;
>> -			list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>> -			found =3D true;
>> -			break;
>> -		}
>> -	}
>> +	list_del(&ni->nsui_list);
>> +	/*
>> +	 * vfsmount can be shared by multiple exports,
>> +	 * decrement refcnt. If the count drops to 1 it
>> +	 * will be unmounted when nsui_expire expires.
>> +	 */
>> +	refcount_dec(&ni->nsui_refcnt);
>> +	ni->nsui_expire =3D jiffies + timeout;
>> +	list_add_tail(&ni->nsui_list, &nn->nfsd_ssc_mount_list);
>> 	spin_unlock(&nn->nfsd_ssc_lock);
>> -	if (!found) {
>> -		mntput(ss_mnt);
>> -		return;
>> -	}
>> }
>>=20
>> #else /* CONFIG_NFSD_V4_2_INTER_SSC */
>>=20
>> static __be32
>> nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>> -		      struct nfsd4_compound_state *cstate,
>> -		      struct nfsd4_copy *copy,
>> -		      struct vfsmount **mount)
>> +			struct nfsd4_compound_state *cstate,
>> +			struct nfsd4_copy *copy)
>> {
>> -	*mount =3D NULL;
>> 	return nfserr_inval;
>> }
>>=20
>> static void
>> -nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>> +nfsd4_cleanup_inter_ssc(struct nfsd4_ssc_umount_item *ni, struct file *=
filp,
>> 			struct nfsd_file *dst)
>> {
>> }
>> @@ -1700,7 +1679,7 @@ static void dup_copy_fields(struct nfsd4_copy *src=
, struct nfsd4_copy *dst)
>> 	memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
>> 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
>> 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
>> -	dst->ss_mnt =3D src->ss_mnt;
>> +	dst->ss_nsui =3D src->ss_nsui;
>> }
>>=20
>> static void cleanup_async_copy(struct nfsd4_copy *copy)
>> @@ -1749,8 +1728,8 @@ static int nfsd4_do_async_copy(void *data)
>> 	if (nfsd4_ssc_is_inter(copy)) {
>> 		struct file *filp;
>>=20
>> -		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>> -				      &copy->stateid);
>> +		filp =3D nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
>> +				&copy->c_fh, &copy->stateid);
>> 		if (IS_ERR(filp)) {
>> 			switch (PTR_ERR(filp)) {
>> 			case -EBADF:
>> @@ -1764,7 +1743,7 @@ static int nfsd4_do_async_copy(void *data)
>> 		}
>> 		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>> 				       false);
>> -		nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
>> +		nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
>> 	} else {
>> 		nfserr =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
>> 				       copy->nf_dst->nf_file, false);
>> @@ -1790,8 +1769,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>> 			status =3D nfserr_notsupp;
>> 			goto out;
>> 		}
>> -		status =3D nfsd4_setup_inter_ssc(rqstp, cstate, copy,
>> -				&copy->ss_mnt);
>> +		status =3D nfsd4_setup_inter_ssc(rqstp, cstate, copy);
>> 		if (status)
>> 			return nfserr_offload_denied;
>> 	} else {
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index 0eb00105d845..36c3340c1d54 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -571,7 +571,7 @@ struct nfsd4_copy {
>> 	struct task_struct	*copy_task;
>> 	refcount_t		refcount;
>>=20
>> -	struct vfsmount		*ss_mnt;
>> +	struct nfsd4_ssc_umount_item *ss_nsui;
>> 	struct nfs_fh		c_fh;
>> 	nfs4_stateid		stateid;
>> };
>> diff --git a/include/linux/nfs_ssc.h b/include/linux/nfs_ssc.h
>> index 75843c00f326..22265b1ff080 100644
>> --- a/include/linux/nfs_ssc.h
>> +++ b/include/linux/nfs_ssc.h
>> @@ -53,6 +53,7 @@ static inline void nfs42_ssc_close(struct file *filep)
>> 	if (nfs_ssc_client_tbl.ssc_nfs4_ops)
>> 		(*nfs_ssc_client_tbl.ssc_nfs4_ops->sco_close)(filep);
>> }
>> +#endif
>>=20
>> struct nfsd4_ssc_umount_item {
>> 	struct list_head nsui_list;
>> @@ -66,7 +67,6 @@ struct nfsd4_ssc_umount_item {
>> 	struct vfsmount *nsui_vfsmount;
>> 	char nsui_ipaddr[RPC_MAX_ADDRBUFLEN + 1];
>> };
>> -#endif
>>=20
>> /*
>> * NFS_FS
>> --=20
>> 2.9.5
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



