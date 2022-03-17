Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A724DD144
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 00:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiCQXsi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Mar 2022 19:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiCQXsh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Mar 2022 19:48:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549062B5EC2;
        Thu, 17 Mar 2022 16:47:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HLY7jv022983;
        Thu, 17 Mar 2022 23:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KcifdkbNtBYZiAnCzKpiO+5ZvWtPkizuEat41ct6Y3o=;
 b=YFkNdW381izgZ+oWsXOtwsBP1VrtF+W3Ijis7NIhZ1KmIgGYiq6h3ZlDzvCmn+51VBiw
 pHU2/bx5YxDJFuxM6xp8G1NQj4K4A5np8o1FJus0U9moBfH9KamH7PQaNvMS1oUR6LxG
 vadAFaoG6etTksi1HX+7W0A5XZF7yOky7pOsbagxewIz2nUpHQZSCqgwB9BxwvDMHNkr
 1L8n2zVGcoCxzw30J4TRDJqThOIwkXzeQ3aYHeBYPavGVwk+D5WfZMHaz+tGYnOR7jZp
 +Q6euKlliCbu+o4UJINmDweLUdSR/kctodVFj9llvwqnmosX1TZUtmoMaArCso07pYi+ 7g== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fuaxnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 23:47:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HNee6K054920;
        Thu, 17 Mar 2022 23:47:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3et64u367q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 23:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezz5IgStHm59KPqYihkhqryQk64Li8b7URIikcjo1/Wa3kBlIGMzn8aAyCe1vkgBEuHKwDj7ituW7WlABQloGjqIeDCQJ1NQNu/BWP0pGsREynYFQne5J/7qUVt2BwiE2x0EjujO5AiTC/yVkq7K03lE5fAsjl6BOPWk4ZKaLe6JldGuKrJTDUlWmoVhbNR3pJgbceRBJcHtigXewadGfLAFVzgmsXN0JCVZrx2kyAW+OF85KxJRcwLUfM6DR+BaMjJnDKJaA7WR3jiiKG6xO6f51lVTl2YblgrgGVg/IkbeonQ9rj1LPLFl9sFWcE45FpmYeCKf3ulJwKENP8us1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcifdkbNtBYZiAnCzKpiO+5ZvWtPkizuEat41ct6Y3o=;
 b=T5B4LwJlopLN4Wue0g13oCCNURPOvivjojYaHn+nUupdYrUyJiVgrMsj4KeOqBvAWBuW5VE0ZYtU/YR3atJFV/Nvy4axiXsOGbJG00APo66iBbnmFLMxy5RDJ+cjsphOawLz+xUN3Zgtai65C/Ta1E0jHSh0btl47NxZ1B6Jc4rPUuU1Mw+vjaybM4rU4b8C+Jdk4AeYFYk1yNRvOC06TG0429ISMVwq3YJR0fQ+FlzWsZQn4HzEp1HcRGrggMrhagrIdX0d92cMMHFeZhwI63IGxvYCkVu/jRjneDBa/FIWCprdqKQpmeBgfvxTPIAjXno2rPRA4nC1DlAFnrOmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcifdkbNtBYZiAnCzKpiO+5ZvWtPkizuEat41ct6Y3o=;
 b=t58PTkayekLAB5U4gXIYKkwoi6fpKp2vtvw+dQVmST8q0XyW1604b5gKnkIa4RCezl0iE+vVWXuICwRLN/aWnx92xDvrsPCqrEeBt+yCK7szvqA6jYLsDHsD6dN37zaz3U6VOQ4QKPnXvG27KYjhCsehsJRJPZ2CQIzjMU4OYIM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1884.namprd10.prod.outlook.com (2603:10b6:3:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 23:47:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 23:47:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thomas Haynes <loghyr@hammerspace.com>
CC:     Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2] nfsd: use correct format characters
Thread-Topic: [PATCH v2] nfsd: use correct format characters
Thread-Index: AQHYOi7VDYQCL/xF8UKwiKHmI8bB76zEPeKAgAAAX4A=
Date:   Thu, 17 Mar 2022 23:47:08 +0000
Message-ID: <4AF48752-1CEC-48D1-A296-47C0393F24A4@oracle.com>
References: <20220316213122.2352992-1-morbo@google.com>
 <20220317184222.2476811-1-morbo@google.com>
 <BEEEADA0-C8E6-44E5-A350-09F35662436B@hammerspace.com>
In-Reply-To: <BEEEADA0-C8E6-44E5-A350-09F35662436B@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6188951-a7b1-44d8-1ef2-08da087072d3
x-ms-traffictypediagnostic: DM5PR10MB1884:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1884714855F1769C238C46B293129@DM5PR10MB1884.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUahW5bR9ziB3acWJ4SqQ+1I9RoUSjxGdrthkm4xE3r/KqVwsfenP0Zr0B62SbJx7CdfMBAj/QinIBypop/RChy3qN5F0ENfx3kdy0ZkjVq3vnbHXI1c5qgxT3LIz1schIcCg/L2nrXjDH8MF83fFgi8bePmScAj/ZjhNL07THIEjUxln0rauJbIpmdo2ZFLm1HGku+2HHb0KNm9SCg/VPCGnNFtPw/7KCH669xD6rZhxrY5LsXcBdcEDHuaxxd2GHRhTWXnK0UXxZsIWA9n9dpKj6aPpiq7rekZMlNd+26zVA3OYopy4a8ClKRHInfGzQG+IJttyuy5El+qJBYA6pRBDM7gggEZUiOvSaXFzimPn8UwjjN4Zt0+FYuRcNa7HkG7xpvATjXScGs9xZ3LfwJITfyOfdNxfDTRFv8wm35wIgMcUOD0s+0EHKu7IFxACLgJsyNCniBzX2t8RE5dqRPOn9Dsnp8VQC2gEE4Jhw2rqpXi1jEXSig/Xkt7l2x0fUQ8s/szduxm0bPc5DaTWhS7tFfjwMzfiI1jScuVAy+8O5sLmOLCtZQ+CRpji7yowqNtZshYsm/wUaHyNJnATfGOpS/ncvj0sGL+xNaMOr6D4/aSEQoHk1mPIUQTnj/HoUXkmB3QCSAhQIlBigY9SB5e6pgIiNQIC8cDKJwH69i4Cc+vfMGQkC1fqhbQ/Ras/mTZnVXSN9xHdmVxEa4LZrR94DJ5zgY/GSgErKna/zwWYYX52+ehjmx9qKQCQJVYWY4GSptw+XQwXiN98a2axf+kks1uV2vcqqY0T3eYIcR1skBWVCJEeZ+L/lVJUt07zQL7nXkYCoDSc5PVHHamtjWu6UxYUaR1YxptKgtV9+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(8936002)(26005)(186003)(966005)(83380400001)(38070700005)(2616005)(5660300002)(86362001)(33656002)(316002)(36756003)(53546011)(6512007)(6506007)(54906003)(38100700002)(71200400001)(508600001)(122000001)(91956017)(66446008)(66946007)(66556008)(66476007)(6916009)(2906002)(8676002)(76116006)(64756008)(4326008)(45980500001)(10090945011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g5BUGbKUXjn3Bhj1J9ehfGiooAAYi7YD6reVIWuKCx4x7mDLuH7LMIcrpKFw?=
 =?us-ascii?Q?bXndp+uaPjsiJ3+PBjm4JllEZnQb7xnP1agGS6DVGDi7YvKlfPx6RBC3EDY3?=
 =?us-ascii?Q?aPXYtoCMBD2o2PmtYvkJLV3D9Pw0ajYrXl8rryGbEReKxzMVz4n0j+TDOv7a?=
 =?us-ascii?Q?hIWJeAofNJT7h30yCD81SkFLldAckVbwsOpo17ZvlJvCw6pnyICFV1JPv8mb?=
 =?us-ascii?Q?YjvwxfuDiKqLaAfE3x03ceD01FFGrXQSLIFpncPLFJAGoiL1lpzeF0ghTTE8?=
 =?us-ascii?Q?GlnLgZurTYD0HAQ8adeW2BQKSZ5WVxMOW0t8wBxWi3JWtE0uFu6xLDhQyNat?=
 =?us-ascii?Q?HkG8PsAGVaVFLBtO9APhz6B+01etAK8tUIm5IvKjxW4NPsBrz5M/tlnSHWas?=
 =?us-ascii?Q?aoig6GgVH2rfK+kGTLzsnAmDb2SWPTDX9M8M+c+s9W2FjSqW/y3X1BmYKVoG?=
 =?us-ascii?Q?nkrHpkxBqBqUr/2NFMvlaT5A7QEyzSMJ8YZvY+Tx7zfVb2tfzKp1+1RVvtaB?=
 =?us-ascii?Q?24w8yifRVSC7Zuvp/eQZknWLepr88Nlw/7bk232t7Hv1jiU1nXe60z9AVqV6?=
 =?us-ascii?Q?F5NRJ4AbQSo7LN8MZL9UJJtFyL41JP1/avbX4G0eZxGFnsw/5/VyY/yJgtQ/?=
 =?us-ascii?Q?8touWRikIok6HyWDk7vVRILMLwICDjbfOjjIEH42pMA70ILG3GcA/AIPyKdT?=
 =?us-ascii?Q?tsnZOgS0a3E4zK8NiJuWUtIaKVXlvgYZikh7Vcao723ZzbI0FgSaCdmxDUHF?=
 =?us-ascii?Q?KkVKpWzdxTd4RzEfcwM/46AaoBH27B7HyjtzKCcE4Ur5WQ1S0EjgSsJO3ATS?=
 =?us-ascii?Q?KGrwBXcpL+lkh8J2jERK/8hYFWQ/SZ/aU7K7HSfZhieX4dsdQ+dqT1BnoqWO?=
 =?us-ascii?Q?4e5PrW2cnXq0HXThDUw1ET+mlyCP5qidbSFnXNuWXSp5S5iRaa4DH7ONa28w?=
 =?us-ascii?Q?3AYIN3tCc7SvU7EaWumBH0rt6ge0/OpN8h+ifM9u12Wb9B/Dh3qtBpd0Ntri?=
 =?us-ascii?Q?F5r9r/HyfkPAOKF3G9V9Q4yduZt8xDyDedzhzTc2qy2w4Ub2zsyRmdmJEJ9G?=
 =?us-ascii?Q?SNiFDW78HWZvETEEoSZCEuWBhd9OujW3BZcKgI8jtJW91GDhuRxiecIo6eI3?=
 =?us-ascii?Q?sHmXC5aI5CB82b3S17nWIToDmjfVTz9mQ6Q0UpjFS5HxOB281MJHE34aNiIN?=
 =?us-ascii?Q?bYAneAPtQkticoyGHBPSzf5mH6NjlV9CmpoG2k62Tf+DYUSATpnfmFvQohnX?=
 =?us-ascii?Q?bm9QHBLrUS24BkDryY8MQ3E/MNout1dleyByQK4L5Dk7PahCr9vws5xcO+A6?=
 =?us-ascii?Q?ryTIR26XXgIt+9snrAWQEyF5LMVjZl3fz1agVBwjkCaEcZCN6XNGk9ecQ0nu?=
 =?us-ascii?Q?nGFQ+IxekzfeYW1SPQvy4a43zsCRPFsy6mR+Di29wWGa8s0aWdiol0f5gxYa?=
 =?us-ascii?Q?tHHQi/1xbmDrj7zCF1diI0DeFUXEqz05atngQNJIk7mNfyTIZkBllQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25E648296285EA41A9337697371C2F28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6188951-a7b1-44d8-1ef2-08da087072d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 23:47:08.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEJFupBRemYxwLBvZz4zOy8+M4Y/evocj3V0YMIW6YWY03+8Yvo1m2y2bexdp0pfb9Tsft7RiMw1MWYMgz74dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=988
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170130
X-Proofpoint-GUID: O7CXCa_Z8_gXiyAotGN4qI9I_XHKPH-0
X-Proofpoint-ORIG-GUID: O7CXCa_Z8_gXiyAotGN4qI9I_XHKPH-0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2022, at 7:45 PM, Thomas Haynes <loghyr@hammerspace.com> wrote=
:
>=20
>=20
>=20
>> On Mar 17, 2022, at 11:42 AM, Bill Wendling <morbo@google.com> wrote:
>>=20
>> [You don't often get email from morbo@google.com. Learn why this is impo=
rtant at http://aka.ms/LearnAboutSenderIdentification.]
>>=20
>> When compiling with -Wformat, clang emits the following warnings:
>>=20
>> fs/nfsd/flexfilelayout.c:120:27: warning: format specifies type 'unsigne=
d
>> char' but the argument has type 'int' [-Wformat]
>>                         "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>>                             ~~~~              ^~~~~~~~~
>>                             %d
>> fs/nfsd/flexfilelayout.c:120:38: warning: format specifies type 'unsigne=
d
>> char' but the argument has type 'int' [-Wformat]
>>                         "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>>                                  ~~~~                    ^~~~~~~~~~~
>>                                  %d
>>=20
>> The types of these arguments are unconditionally defined, so this patch
>> updates the format character to the correct ones for ints and unsigned
>> ints.
>>=20
>> Link: https://github.com/ClangBuiltLinux/linux/issues/378
>> Signed-off-by: Bill Wendling <morbo@google.com>
>> ---
>> v2 - Fixed "Link" to be a valid URL.
>> ---
>> fs/nfsd/flexfilelayout.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
>> index 2e2f1d5e9f62..070f90ed09b6 100644
>> --- a/fs/nfsd/flexfilelayout.c
>> +++ b/fs/nfsd/flexfilelayout.c
>> @@ -117,7 +117,7 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, =
struct svc_rqst *rqstp,
>>=20
>>        da->netaddr.addr_len =3D
>>                snprintf(da->netaddr.addr, FF_ADDR_LEN + 1,
>> -                        "%s.%hhu.%hhu", addr, port >> 8, port & 0xff);
>> +                        "%s.%d.%d", addr, port >> 8, port & 0xff);
>>=20
>>        da->tightly_coupled =3D false;
>>=20
>> --
>> 2.35.1.723.g4982287a31-goog
>>=20
>=20
>=20
> Reviewed-by: Tom Haynes <loghyr@hammerspace.com>

Perfect, thanks!

--
Chuck Lever



