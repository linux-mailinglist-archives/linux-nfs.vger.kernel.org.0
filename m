Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A42450633
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhKOODy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 09:03:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48122 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235280AbhKOODm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 09:03:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFDbCeg002809;
        Mon, 15 Nov 2021 14:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o6raYpBrrLEZQSv5beoYaM/YDXW3AxzaRXUERtCOFjo=;
 b=DCzZa3PUopClh9pp8SpZm/RWaCsdDg+XK0K+gdC2m+3+pcIqSgdSQeBCboiWdG5nalPT
 poWjIoOMKc54eRUqjWGV5TWb4HM9nqFB3IvJohujozd/VCRaYA/emRleLU6A+ubGwKxk
 fx+Qzigu4f6PTKpEbW5eQEdKeWs/yEJv45gq8g5rTs8X9icZy8RMvaVZpuNnKJYaiyf5
 WxueQtAf9AnZsfFZQEzs9IksWxLS6cDAzn4ToImA9p9RaR+QiceLiEUUOh8/GuRyg9mY
 8w22qHfNybgtyFMWWZUm1LhmICBZqoJgs1o65ZJQM04b8TLH62tP6ZeB8gZWqGB5cHV/ xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3dtb0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 14:00:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFDuxoG002392;
        Mon, 15 Nov 2021 14:00:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3caq4r0ubg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 14:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS5Re+WMsoAw738ra/9EXkB8npPE5PI5BqLFTgSCE3LHl0gKVPhK3/BAZV0qHVkMvyVkP9I6i/0D98C6fgjIdxop5ne1RMjqtFaa215yhKptwFSx5RBAKJS2jaYalfC63YHYJA2e8v3FFETpVL4I/KnP8T3sIs5ge/U4PL0Bi2W1AVR9dio0ARHOwoEti2Utnu3Nfb3Z9oamuO/3LyQpDSmZ3vE6BaF223IlM1mmsmvuPD2jSVS/r2SQux93w8MKHUS0PE4Mh6FPhJk7Ni40c8Y8ZdN3gjwTyLdrrwlqIx9VXBQTCIbkJZ6OK0D9CMIvdWHuLLp7/qpTdCm30tpqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6raYpBrrLEZQSv5beoYaM/YDXW3AxzaRXUERtCOFjo=;
 b=iM/7nCAUoRes0l9Bq3P6PrqDakcsUUUG21ffTNK/FynAM4l5hEt9Moxn8/kx06VMsyLpHO3ZFuQKmeWoIv2sjwnTvP1Pjn+CqRGzz1EMpSuUuDkCD0c0H9jKpMer3CJu0Xo+xjujgzR4jMQxYrhDI1xv1C7yuktPY0LVPRKn4YmrQVRAJwtSea9R1rA9l/5WwnJ8DBh4gsgHR132vI7Q4SNmN6Js13q9mPIavMrdPWap8OXXHOi2WOHoEq0AduBOQlmAvrVrf3XbkPuK3lVSWJYr6mBJorN4ffhi+7ut+K09w5xUELtkHP79skSmJZjl34rzaEhWED8GOdJlWbCtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6raYpBrrLEZQSv5beoYaM/YDXW3AxzaRXUERtCOFjo=;
 b=dfur/GzslMLfSN5a085e8SyHXciLQkdNQemnRiVnjE0KB0IdhYgjTKXFRidtdz3xqhok1MgM6LVUVvlJltsU1o7p3dz3SDrBnKX/r6VhB/uod51Xzak1dB9fzqSN0H4VC7ld7OrRmSRfBzc0fVBDZVUrp6yfQR4cnKUZ9hhOdgQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 14:00:38 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%6]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 14:00:38 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] NFSD: Fix exposure in nfsd4_decode_bitmap()
Thread-Topic: [PATCH v1] NFSD: Fix exposure in nfsd4_decode_bitmap()
Thread-Index: AQHX2ZR6iDCoondE30yauXAcPh/lE6wDknSAgAEMt4A=
Date:   Mon, 15 Nov 2021 14:00:37 +0000
Message-ID: <75118200-2FC4-41F6-B3FE-7E7DAA46F927@oracle.com>
References: <163692036074.16710.5678362976688977923.stgit@klimt.1015granger.net>
 <41221367b0ac816400bd207e08a3c4e17af1c21e.camel@hammerspace.com>
In-Reply-To: <41221367b0ac816400bd207e08a3c4e17af1c21e.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1817e383-d2a0-4a3a-a1fc-08d9a8404d7f
x-ms-traffictypediagnostic: SJ0PR10MB4623:
x-microsoft-antispam-prvs: <SJ0PR10MB462317B26C3C918D6008C10393989@SJ0PR10MB4623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpcssFG1VZI9QTypebhV0Nlya4tmZaRQBKf7Fr8ij6he8xi09NnasFu9Baxaxdw0jIPjQlLMEWM4Alq5tYNCvCrXbXBbiP8+CRsJrFJa7ld8JXv8MyNjX4ewIvNvec4LJtbISPdEKJcDMb6qR/fGJWxAX1Zcyg4rudjhtrq8qjkkp0EHqfu45gUVVzQMpbAzW/Ipm5zLX+s3H9Bc1Gd/1O30+BPa9iKUDcolrDnD7me2IclejI/zMo16IzS4TesDl1GH47hw5G2DgF9keYkyFYYAlrjqaCU+ygmPZXbkzeOJ6zAShYiD4uqS1oKx9nqiAnObM76aGp7N3anpVq1gghTxek40gplHWV4294L99g2kV74pjasJoRS23YM5DX9yXqywdSMFCthHu18bLl3TFb4GarnOG+/umD1ElTFeH0VPtmP0eSLOdC/f7yl7CScXF/BVhUfKTsmogn7Fq0PKy6WmQr7eXviJPM9BXy9ZQeRpdkJ/il0xync6ZTb2EeBjLSLnUABD+pOCh2hsgrH5kbkKRirGTdwfvFO0s5Taks1Ssoz8+vRxZVdXvpwf2fYNVKW4nIakGGA2K6uLHI9G/PysypspxeS31BiLzYoSZ/jeNSu/uLk87ZWtiJCCNiIWL2wKHwzmX3hKE80eykitD9HiTAXm9mWbxVt7lu6HpCD2nuO0tFfLF4d6zkhAuLerl1uIm3fnZd7zsUc2HzZCWK68y4nO8amCKVj0IouPbfJn7l6hYBA8Cd6Lb6/P1+bi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(54906003)(508600001)(2616005)(122000001)(83380400001)(86362001)(33656002)(38100700002)(6916009)(186003)(4001150100001)(316002)(6506007)(36756003)(53546011)(2906002)(8936002)(26005)(76116006)(91956017)(71200400001)(66476007)(6486002)(66946007)(66556008)(6512007)(64756008)(66446008)(5660300002)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/5SKUTK6vo9gZJxmjugigVXrbVWBuznBxZCJ9q+pVVSom30w8XnsiT/UrRkn?=
 =?us-ascii?Q?4A8vvduYbjqY7Jhj1xlrrMkggTNq21E+/gLGWGGvDiiJe48A1zm1Llb3Blf7?=
 =?us-ascii?Q?JESI3PYKbwE0Q5neBmacqVfYvoIRj//3487mEfHdVd2UXDAFUE0MutTsCaNn?=
 =?us-ascii?Q?9YYX8rJCOdI2JcgD0pJDfgoHuEuw+ReXIUVylFmYKcXZitAbPe/8c5Iaho0x?=
 =?us-ascii?Q?Ccm8yhCSdZfufvA/a7Sh4Y1QOYAi1T5rYJxsQa+UuKkBL8mE3B0DlifyMAVq?=
 =?us-ascii?Q?CmfZSzSSAkumqCouGERe11AjLoh31T9PrQjDPFf+Gz0SgNpmeJQztHRW1eal?=
 =?us-ascii?Q?HqLlihoCVlb2v868A+s/Ys6m9OJhH1iCa+nqdafZNpG/2fBDFpQiYJMN8rNF?=
 =?us-ascii?Q?OY2EqoBjO5jkkGczGhBp1sTooQrYapWruP6OoCBMwZfodqoGYvPSMgObvnMx?=
 =?us-ascii?Q?cfc2EYDE/iYj21S2ou8Ie6yzOiopfRaEPQXSDB2ZGmB6QWhfjirBbcQrt+tf?=
 =?us-ascii?Q?cU9DHDsNtkQ/0lIYyprIedBCYzMh7YffQ12j713WppPUDJVF139ju+e1n1QX?=
 =?us-ascii?Q?j76Wqj1Oh9YoxpsHUhPnSI+Y0qKyboHGOu7uVMtrvHEdoDWefMTNLAYxTygW?=
 =?us-ascii?Q?XlOSV7B3mQqi0u46LdYiYtXBoMANaGrVzTy/zp8te3zfvk7YvfDYBZypCZ+b?=
 =?us-ascii?Q?OWjr+eYYilRIQBBU1UuehYVHVw17vJEFdBFcF+7AgkWbn4s7sHmIIJuuM2Iy?=
 =?us-ascii?Q?YXfkHjl0t/G9mB9WeUupI8oVH96VQaRjvbtQcE7E1Bl7lXEl1s8gTzsMkd+r?=
 =?us-ascii?Q?PRqnbIfPe4YyW+mEV4AIso5at27hfReHE4QiKnRoeyJPQ2WkhnawQUumfd9v?=
 =?us-ascii?Q?TzFCHuVcmh+ywpJhsJrFZnos0kTFu7rOhm6z+s7KeiWo6SYfl53Tk8O9gIzI?=
 =?us-ascii?Q?bj3IGtE2BMiKzO+8yByNADXlV/IEebAp0ApbVxc9MMpgO1Fk0378Pj2DDXek?=
 =?us-ascii?Q?g4vGRYZy/q5JDwnimzJwyzTw730tEkxsaxxHhSvJSCMzf/e7wUPzjZElpndx?=
 =?us-ascii?Q?Clxcxr1ObEz1ClDFPRK8EgryEk2tRBSAX/hJwPNCEBnwdwDFIy25bHqPHYFs?=
 =?us-ascii?Q?9VGKkKowG9HXGuTBaVq5lqbmN+v8KGIxYn+EoD2VYkjcOD154G9qz+H6w++7?=
 =?us-ascii?Q?OlgONlMjivdCmt84rba69dUX8Xy9TaETPJHIrGIwFxxSa5+r2asMW0IgLVw5?=
 =?us-ascii?Q?RfndAkwHUPFLPARIpIPCXR4NaNuaj1WsnVQ+yiBjBdlOy1AzOvPz61B0EkO3?=
 =?us-ascii?Q?15OC59xy3vXzdk5y3Bslx84sTdng+bUQ1FWIxsQ9h/9YRDfyvMf5nYB/NLXx?=
 =?us-ascii?Q?4HrWrUOyWekm0KfXfUy7tFtEdtUTrkU6lUWOiZI+fNaLtkIWlR8Il4kN4xEC?=
 =?us-ascii?Q?HkUzoLWFbe2ZbFrsxsTe3nHT6/e9B9wxasuMbEmRs7os9SMzom7BI1vzXHOy?=
 =?us-ascii?Q?+hb25DOh3VsDC0uU/TQ73RXZKW9TfoQUy8mHmuaJa+EDq/Ye1HPfp89DzxPe?=
 =?us-ascii?Q?cjTZvCe8KLlqC6KGmZBpwiitYhe6gdrjOVgLNKtXs94TVUf6foPvmg42M3YC?=
 =?us-ascii?Q?1oAKhjksD87103bTEML/Q0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2E8FCB8E8BDD94B9BBB632345DA28A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1817e383-d2a0-4a3a-a1fc-08d9a8404d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 14:00:37.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sZOTmBA0lul8PeOpdNg3MouvPWi+CI7lN8uXtbXm8cFawNhfbd6Bd38y4/28wdwovkFhCP2P9/KrpTez54I8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150075
X-Proofpoint-GUID: KKxig53YBJMM_oei5McIcgr4duuBPWsn
X-Proofpoint-ORIG-GUID: KKxig53YBJMM_oei5McIcgr4duuBPWsn
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 14, 2021, at 4:58 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Sun, 2021-11-14 at 15:16 -0500, Chuck Lever wrote:
>> rtm@csail.mit.edu reports:
>>> nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
>>> directs it to do so. This can cause nfsd4_decode_state_protect4_a()
>>> to write client-supplied data beyond the end of
>>> nfsd4_exchange_id.spo_must_allow[] when called by
>>> nfsd4_decode_exchange_id().
>>=20
>> Rewrite the loops so nfsd4_decode_bitmap() cannot iterate beyond
>> @bmlen.
>>=20
>> Reported by: rtm@csail.mit.edu
>> Fixes: d1c263a031e8 ("NFSD: Replace READ* macros in
>> nfsd4_decode_fattr()")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4xdr.c |    7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>=20
>> Hi Bruce-
>>=20
>> This version is cleaned up slightly and has been tested as follows:
>>=20
>> - I am not able to crash a patched server using rtm's nfsd_1
>> - No new FAILUREs with NFSv4.1 pynfs tests
>> - No new failures with xfstests on NFSv4.1 or NFSv4.2
>> - No new failures with the git regression suite on NFSv4.1 or NFSv4.2
>> - No reports of NFS4ERR_BADXDR or GARBAGE_ARGS during xfs or git regr
>>=20
>> Hopefully that exercises enough uses of nfsd4_decode_bitmap() to be
>> confident that it is working properly.
>>=20
>> I tested this on top of my XDR tracepoint series, so the line numbers
>> might be a little off from your current tree. However, it should
>> otherwise apply cleanly.
>>=20
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 5ff481e9c85d..479d3452ce6c 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -288,11 +288,8 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs
>> *argp, u32 *bmval, u32 bmlen)
>>         p =3D xdr_inline_decode(argp->xdr, count << 2);
>>         if (!p)
>>                 return nfserr_bad_xdr;
>> -       i =3D 0;
>> -       while (i < count)
>> -               bmval[i++] =3D be32_to_cpup(p++);
>> -       while (i < bmlen)
>> -               bmval[i++] =3D 0;
>> +       for (i =3D 0; i < bmlen; i++)
>> +               bmval[i] =3D (i < count) ? be32_to_cpup(p++) : 0;
>> =20
>>         return nfs_ok;
>>  }
>>=20
>=20
> Why not just convert it to use xdr_stream_decode_uint32_array() instead
> of maintaining this separate open coded version?

Pulling the chain a little more, perhaps all decode_bitmap4 call
sites should be converted to use xdr_stream_decode_uint32_array.
We could consider that as a clean up later; the current fix has
been kept surgical so it can be backported.


--
Chuck Lever



