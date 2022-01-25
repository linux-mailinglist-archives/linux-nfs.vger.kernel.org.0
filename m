Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE549B7FE
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376543AbiAYPwL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:52:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55932 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1582473AbiAYPtt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:49:49 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PEwrlL020683;
        Tue, 25 Jan 2022 15:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GWDJhXzRgWzRDX426G1kXNz4QyLlxHlA/Q+I9Qo0qlI=;
 b=ddR2hEeAZzdPLyDYvggCjx3GpUTc/8Ufj04tZIjxXdpSN4LgZjdyoIjbOcUYgNnLTCC3
 qH4uCBY0UVAXD5q6iis1rmzH7ZHVI23lArji2Yy/gTi8uo+qwn1+pbtCaPx2XtJF+dt+
 hdk+Z0Oy2xOXeAyvxggRjCBNbWpCfj0Yc4V95eFUqtrM2hEbZ0wyJDfuQUY7WoMr8xm4
 /48YE9YkKLduQOeZ3N9DN1MX2i4IL1eRy0mNDyJNsMhKbGydlSbBPlrU5IeMn3Rf+tlk
 D50aDa3BUo6cVOxZkQlwqgSatMq4yEhIPjG1QeO0jVmwNh6jwebfLBN3saTSpa7S1vMD aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9kqvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:49:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PFkxT0098005;
        Tue, 25 Jan 2022 15:49:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 3dr71y6b2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgiFWmI44CnGe1mWNfIQ8ZBAqPawUaWjCaxTU7Vve8gkS8Vawl27KTdP9EmXbosTxut2ILlPCzY75ogDs2fXFaU8MyCBhl3iJtot8jupIJmDlZH4LERkjq4o934KreWkZr98gPg6rNW6nw9gN6vQgPlGGiW09Ky3vkvR2ytBrsAhfj3x3gyrAA9E80fDn2KjUpsxRFS6QsWFgd255qdB1mNUfT4kYgfkHgTjXF41eWSgmnv46IGxlQ9uimmoxDjlB6M7n7ieYOXIAmRU0lhqYhwHL4N6zWc7GtEeW60GpKN3kz0qoGTdg7H2ma96dmZuGY7HRxDnOaclK7lsnYYSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWDJhXzRgWzRDX426G1kXNz4QyLlxHlA/Q+I9Qo0qlI=;
 b=mAJktSzDjLTLvfXFdwlbD0jk9yucAsKPZikAjcgQl23AYZzmdVIjzV1COKqv8bNLWjBoq3R4hKg27sVX6ClNITgvtLVx6Y76D2v6GkBG2jh/shiBOiiP22JInIvtAhTItzpxb+1EJ64Laib9eXE8o7BnIiQqC5nMu6c+zsxYvUDRUJTJxvyj+F6ukCigcONc1HGmoD2WQXxJtz8FVDJO22iQQ6MN7ehDR5gp4GDBsHU+qWPachIfFoznQRYJEXsCfq6oUjeifgGJog1jlVjwq56j7HlBa/l789Dp89TnMBIp+cyfjEWbsJMN8/qbAMJpiHG1mVE+w5ZULteXRVi2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWDJhXzRgWzRDX426G1kXNz4QyLlxHlA/Q+I9Qo0qlI=;
 b=z9GtPD48NXWVL+qCx0CKLtDZp9vgUW/xjHHNOBh2aDY7GaL/V2DnLbtjefN4c5/dsAtrijfKOIQ7wiPRITMvsatqkqhIk7HrIONnmPx6vDKl6G+8KGjsud8pjHWjg1nm7kKXTLgRVyc3XD2H/F+zfduJZUJCuGuxXiT+v6G+BNQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 15:49:10 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 15:49:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: runtime warning in next-20220125
Thread-Topic: linux-next: runtime warning in next-20220125
Thread-Index: AQHYEaktcg7+1kysjUiIdD4hmV/HjKxzM5EAgACiBACAAAmigIAAAKCAgAACXACAAACqAA==
Date:   Tue, 25 Jan 2022 15:49:10 +0000
Message-ID: <7EFDC21D-62D2-4CEF-B9C4-B22FB1ED3F87@oracle.com>
References: <20220125160505.068dbb52@canb.auug.org.au>
 <20220125162146.13872bdb@canb.auug.org.au>
 <20220125100138.0d19c8ca@gandalf.local.home>
 <20220125103607.2dc307e2@gandalf.local.home>
 <E23F5174-F706-40FC-9072-143B04905208@oracle.com>
 <20220125104648.7ecce604@gandalf.local.home>
In-Reply-To: <20220125104648.7ecce604@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bca4d0c4-88eb-46a1-14fc-08d9e01a3aaf
x-ms-traffictypediagnostic: CH0PR10MB4857:EE_
x-microsoft-antispam-prvs: <CH0PR10MB485711B2B2BB007A15F198AD935F9@CH0PR10MB4857.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSAPHqn3UnFza2xzGHpqoi8uXrDE82Oql3xXHT/8mHSXvvaeI6aRKM40+rfFQTr6pmY2n5Gz0jtIDLwLAaFOnnNo3pPSl3vajgVTplJ+/0PpLYJnqJhC9HS9uMoCd/wEjrWvnrrihehQLckiX5va0Q1uB7AvFJjJmQBzawRvsXkJrmzNJi3S8TpkJQ6ol9v0cvTK9gp+SWfaJsa7Vp+1fKclOrVFZs2Q48ZkXFBxn3rSLVlnVPte+snpvgEMRB7m8Fli9SZK/FyORFeojudANTD3+lxVH6EKNrg5dxGZ4mVt/iHRveiCbP3e4rZ8OVnWmuxX5xQEmo++D8F3optIeqTD09WU60uRM2m8Ykn/OE7Vy6NSiIOx5N24LeZB8e395a/Lj6HrCBTz3k1lZKgeVfjcQ2MQq3HWwvcbzwUZdMKJzXzH4DwG+g1teRAuk48QwFNTkVQs/8/lcEatCLuWg9+Ob5m7Uqs6zPRAo35IrU7TQ9umY/7PhZAujvEyClWuUEWfSVd6h+VSuD3sAJ/qWR8kU5kQ4hsXhq7tPoBV8Zt8X7mwB8/4NHInGgmBOoTM53QBsOn1ylBtBMKvxLuQO9R2gP6C5h6u//c9rXUAF0XY/nuJnNL8/1Vxk23DOdRkZqk4UBqa0lHY4V1qY5LCaF7lpg8ojngJBEejNnCgfrsEWShCD8fh1kcntIfm6nLv8PNsNQsP7GuFOMmFa11hAEmWY5Xp9E1ySOnafYIKQ8i9Z4usz93oJFABOxVSAnZA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(186003)(83380400001)(6506007)(36756003)(64756008)(6486002)(33656002)(53546011)(4744005)(66476007)(316002)(5660300002)(66556008)(86362001)(6512007)(66446008)(66946007)(71200400001)(26005)(2906002)(54906003)(4326008)(38100700002)(122000001)(8676002)(38070700005)(8936002)(6916009)(508600001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UCR0v4J4jhKb0wawJaW7DzrGMw7pWcTPXH5+NzhK3JD9NO6GXRpf5xTzghYK?=
 =?us-ascii?Q?kz5qPRBRN/IrVt4If6mALkP64FjSo7yReytTfC+sZ53l8kv/2B8kn/zskxzD?=
 =?us-ascii?Q?vKZlz4GB4iVe/+MkDNDwasfCjVia+nZ5tnGhfOmHJLi1amoshFFpatLFnTly?=
 =?us-ascii?Q?J5q+8fcZc/PqO51JNTiiWHDc6n8DB7dx/3ix9j+hONdWyqrSrK1YkPnQUHBx?=
 =?us-ascii?Q?EM8Za1KMjeWoKsB3KPXPp2U/1YckdZ6VrGYWhB8wLQ7aVWCbhAFoTzlXzTdp?=
 =?us-ascii?Q?0Um8Ge7gau0T/NTwibPrG4KRqlsL/8pxkoN7Xnnlr+/pgojFIKAHeE0KfV2V?=
 =?us-ascii?Q?279JvLPKqDi3wVjtxmeTYVvgyJ4VkW/a8R3mXZUR18knOY3GYramlojK4D7k?=
 =?us-ascii?Q?6zHHwY7ifvN7BBPW09yMCyNpCPp0P+VdsWW00dN5ymXtir4VxDl44m56bkF5?=
 =?us-ascii?Q?2zg4PpfuMXOUVymGRVfYUlue6Aag92/OTynliVCjzZgT+9PG89/D+6F+oMH8?=
 =?us-ascii?Q?r/Oz8ycvGTCivBmz6ZuvglY1Y7L5nF3VvZHTP4bvdjiCGLo03j1Fo0i4dvSk?=
 =?us-ascii?Q?wOZd1pOmLZmOI+P/EARW6KjlLn7hE0+wzB4NT1UxJVPCjHmdc+jPOnwu3JEw?=
 =?us-ascii?Q?a0IuNmug48E1tPqjNuQG9idKomcfAwnA6wDxHjN1uZwPFzHMSFf4tN5s63nh?=
 =?us-ascii?Q?A/0LGDB0Ivu2pNR4HFP3IQcpSPteA/sdjWIgEY7jYl6FJoczRfc6lWgsXsuf?=
 =?us-ascii?Q?YM07/8tedR2+KX/2SWyGzSGUlfv6hbBx7A6mxXiWk4pXHiFtu3yzwyXwtde6?=
 =?us-ascii?Q?1w7FJwTtMmFvQ+R9kVCne+Pb9AZTxHnMFZcGgTmuFAnIgjnnz+Cz29JtJzJX?=
 =?us-ascii?Q?zvMj9+jmF7y1Ju0tsWJWFuI1EN/7PEuhuH5K+NuSnk3PotPIo0GMidj6oCPN?=
 =?us-ascii?Q?VtZNlu6r6tE27ZeF2mZ/v4FG7vq/G+glKJCAL8zk+zanAvX+Pyxn6un6lh9H?=
 =?us-ascii?Q?jyDeJPf8nxViKnr5RVIHhFe+hNM6jUEm4C86BkmXA7vptASVEyvaiRZfwSX7?=
 =?us-ascii?Q?s1b9ycRjoq2iJMdoeas+FDQhx1lM+bw4c5xWj21GuqGwdQeMf1WORmNJSzkE?=
 =?us-ascii?Q?0MGC34SNC05rkLcKifpb0jkitj6w9vAct/W4TB+DODPNyDQZIox+hymnoE1X?=
 =?us-ascii?Q?SiGyGfwtycGfEGu/rd2W3x9hIrCOBHafbDiv4SVh6rQ5cQWDbc5BhdDIzfem?=
 =?us-ascii?Q?Me0AfdLKX9rs1gzkTDjVHeHT87jGq6pu2GQv805p7WatuqF1Q0oWbfRM1St2?=
 =?us-ascii?Q?SvSP4IxXbO9o/6LREcV/0j5pAnfxAM1h46zzHuTs5Kr8f6LgyoDgPdYSPL96?=
 =?us-ascii?Q?Eib/SKYR405aD0k7RALX1n1au+rqmo/D2jrWq5/HYrcmvuj7M+1uIyJnnyVi?=
 =?us-ascii?Q?momv1sTfFrn2gDBCnSa5UjJN68+Hrx+vGN/yyxG+gndV13jl0GLVOq6hukgL?=
 =?us-ascii?Q?M2HQmpMxLGXSt2MeF0Us4ERlh48/8T+lbJ5pEcdNtGQ9qQtGCX9GZzrTW8Ld?=
 =?us-ascii?Q?RWFKKQL+2Tc2wvLDCaGOziyJNIyd1n+fUQDfyvPPJc/1xM7CmqiS+1lTG4s7?=
 =?us-ascii?Q?VTIA1NdJUZpLWHHTIhhTO50=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5B6C163038FE849B9890D9C5C5A6592@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca4d0c4-88eb-46a1-14fc-08d9e01a3aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 15:49:10.6866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OBXw20zdIZpsOJI2PTShHvQoY6HJhRX9F/S/0I2T2H5Z2DY/8ugOEcsCB+4skuMTCZtHFSjQowMaJQeXcDOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250101
X-Proofpoint-ORIG-GUID: EE7GDiJ-PP8sPE2ECaDZJujjzzdDeBBd
X-Proofpoint-GUID: EE7GDiJ-PP8sPE2ECaDZJujjzzdDeBBd
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 10:46 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Tue, 25 Jan 2022 15:38:22 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> This should fix it:
>>>=20
>>> I'll make it a real patch and start running it through my tests. =20
>>=20
>> Should this be squashed into the patch that adds __get_sockaddr() ?
>>=20
>> I have an updated version of that patch that applies on kernels
>> that have __rel_dynamic_array.
>=20
> Heh, I thought the patch was already in mainline.

Nope, you said you might still be testing it, so I held it back
from v5.17. But it is in linux-next now via the nfsd tree.


> I just posted the fix.
>=20
> Just add it to your queue. No need to squash it.
>=20
> You can remove the Fixes: tag, as it may not reference the right commit.

Thanks!


--
Chuck Lever



