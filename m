Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2F433C6F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 18:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhJSQiL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 12:38:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35518 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234395AbhJSQiK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 12:38:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JGNhO8019896;
        Tue, 19 Oct 2021 16:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5ul1BPr2i5G51bmxtATJnA02MBPgAx03EGAj138d7Ew=;
 b=Hnc2recS+vO9SrOiwBgUmXflUCBhB4Yi/qv9lt+QB4SYsje9S7wJuiu5bHaXQISwVTSC
 eIIOYPM5IVFzlHN2/LTav9pAZHtl9YeXrQUCkDfUaVJZ4UsBbHc+DzpCF6+YxBA+ssay
 DXP7s1XkGiJrFR4WwUHwC9cciHSR/5VtBVoTfGIfXVcmxRYegGnihFI6ZmoUHrtQ+J6U
 g1UeKX8sV/utwAA2lbozbSe89iBNH4G1mlRKjKoPXl/G4t8pIal1h5ZXerC8ZudgiXT7
 NcwFD0qoCxXtOUjZrSWcr095S7DFFqo5IloE5RSFQcqm/8Q/rvSew3+2gHyT6iuidzA9 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefbq56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 16:35:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JGZYZo081887;
        Tue, 19 Oct 2021 16:35:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3bqkuxm8bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 16:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOOAlvY4e4CSuaOZbAUZYnJkUrW0xDohr8PhBUUzhrl8g4xMQuJ++RCu0e/egGOdp3MzSlr+Z7owfMxI7S8/u7ACHNCD+kPoS0nuyQLcwkI9ZsWZDS5o1MGhW4zylN8aSjmFMOJPieLjv5ZIB0mNYQiMsKtZh2oXCLRcHl6Nvf3B00EVfM0rYz18ld2ei8Zy6hZl4feQYB5cM4TpcThezuYHVZZoBkeef0M33UiNlYE3hdYowBE93B0ey3AplwwCVrLF52f8iliLtJR2V8I0Q5aTHkFq05/4EE51Ul4Jqd+0BgE0kiiP6fGn0ZwOhjFJDvlsuzxaldPBWlu8Nu/8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ul1BPr2i5G51bmxtATJnA02MBPgAx03EGAj138d7Ew=;
 b=isNrYrPTx9eI8fL2UBfxm6xwGo95OxhvVUj/4j1mex2aL5yLmS2FP9yTwdRSe1RsSAFD8VHMy1CBkPYn2qSoOcZl3Buia7qooyvfKZzTfSaYIQcflXyVsf4pYsJaBz0UfbtjsAEQU2Fttpki2jQy7YFrLC8v7inI3Jsps5NNsw/Dog6n9TO+6vNRjar7qfSTafkOeja4DhbFmgy2zWfX9BeDaNIG99j6DLmTJNHIzPFNF04Exm3IWgDszwROi5p/Yi5gfrr0Dr32NJpP2K/SCtKcL0HdQbHVCUnhYzGiW889N3rRpyuu/oPFLzPgG04ITfqrmY34nNqcnZodoMubQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ul1BPr2i5G51bmxtATJnA02MBPgAx03EGAj138d7Ew=;
 b=mRV0p35u4eWNsstwDTPWiPUKqsyqfEoS+cWfurPstd+zIup295LKfxFlS8haDYG9zGbZRIG6YNXYHOmQ+DZRNrmnrJjn9J7uuhilLZj44BtxykXbinr8E2nWGQOFqqQLC2OE8FcJOAS6klRJiEvQPpcigFNRpbocHdv4dEtXvk4=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3461.namprd10.prod.outlook.com (2603:10b6:a03:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 16:35:48 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 16:35:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
Thread-Topic: [PATCH 5/7] NFSv4.2 add tracepoint to CB_OFFLOAD
Thread-Index: AQHXxGwEJEU6hcAUf027GKBIL3/nzKvab8aAgAAMaICAAAm2gA==
Date:   Tue, 19 Oct 2021 16:35:47 +0000
Message-ID: <C818DA0E-207F-4FFC-AC38-61F58C131787@oracle.com>
References: <20211018220314.85115-1-olga.kornievskaia@gmail.com>
 <20211018220314.85115-6-olga.kornievskaia@gmail.com>
 <9B0CDAB8-670F-4D34-815D-49AC44B4DFC6@oracle.com>
 <CAN-5tyH90dMe2QyLXVjZBZU_BV34a1=xc_NhwxDQmt1MbcnXQQ@mail.gmail.com>
In-Reply-To: <CAN-5tyH90dMe2QyLXVjZBZU_BV34a1=xc_NhwxDQmt1MbcnXQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bdc25a7-f572-46eb-addb-08d9931e818e
x-ms-traffictypediagnostic: BYAPR10MB3461:
x-microsoft-antispam-prvs: <BYAPR10MB34615F2BFDA4AB01116015D393BD9@BYAPR10MB3461.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PeOQQIAXitRNHsStWnZUZiP30onyp9BFlQ5TkA2nrZnbz9VEGi1agR/OBBMhinaZYgbnDN5Qc9QkrLvley/ucFaZgG2jueapsreQt9PWuqvbpKQSjJ7wDjXklWcPNjj4kkvoCkM9VX1nBAV7VGOWHI2gzV2vZFAspDMpZtoarB6b5wNnDkrri9xXP3KoBx8xTb5xt7bjsknmik9OS1m7QVM0/GugYpfdKecvMVJU3LbYTaEpDaVvsskQE9Y+DxmmEKUHiHuSO/3oe82Ax0DoADz9qRizycBLOP1Hcm6X2Iiw7YfJ9ohhDUiU4yq4FozGgJDQnY5x4q5sRdAH6ji+WUQQmKF8taVnrP7ct065gqjnuyGfWGH0LLM+uUAgE53owJxMzWbF16imuXKuRiFpPMDwcySLDWOiLProDDK4e7D5YAT9tCYRaekV1A1jW8B7KIn8wKSITnAyhmSTqxnzR5xCPXzBShDr62+9GqB7YNNc9kbPk5PZrmTa0OPruEx5FNlj1v1puZUSNnqib5cEH3yMJqmMzlkd2lNflwu7+nock6X/qAn/H+qI4TPeBfCzSWMXngdi3OB6MueFrDE0yTZ8C9BV2C/hnl79NKYRFZ+/r19pJjAMOPQ2DwJIuwUuFKwTr59N1fndqb+nttiIO4LbtGT6Cm5XClJ4k1w1lPQZzDwp9toBY2Fbu7jG7/n3C923Rx6IoTnq/QXxrFu2oxhi7Gv00cVPB82mxGZRLsKjODRfY9ks88/N3XQMmbrvY+ndKlaIbFZMV4BfRSe3OTCg+U9ti+VQ5k+T9k865HHEB98Tfg6SAFFyQBVQZOIgFSDm7SHCKidkHm23kN26muvU5yYdPewm1squXFRrmk0N3/DsXv2++h3KT1vLo/uJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(2906002)(186003)(6512007)(8936002)(508600001)(6916009)(66946007)(2616005)(36756003)(38100700002)(54906003)(316002)(26005)(8676002)(122000001)(86362001)(71200400001)(33656002)(6486002)(53546011)(6506007)(5660300002)(4326008)(91956017)(76116006)(66446008)(66556008)(966005)(64756008)(66476007)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kS6N/gMeZjE/59S/s/MyxRMVkamQvwClNwfW6wx/ubo99Oi1hef8LpMNj4c4?=
 =?us-ascii?Q?MN9YHsOY7qehPcRVFFdBfW0sUYvRfD6Nm9Jidp7W/ZVkklX0pHrWQxK6JbVW?=
 =?us-ascii?Q?WHhRffDH+fVtlAZlsPTK5xM51sXSnjR3T6J9gh5y88J1eOfK/IKHC7sQZYSy?=
 =?us-ascii?Q?Eu6P7tAcvHWpuyAHaTeRt9uYMg4lQqX3YqW5HIoAmqupHkdoeFI6QMj8ba4c?=
 =?us-ascii?Q?jgF7g2NSB3T1EDlsv7FegUHwX+KLLgYDPl6RcoBM8AxBwm8O/xQS6UGva/cK?=
 =?us-ascii?Q?xDGghM3lj0RkBSoc0Pa4j1aixojdM1D+U7QU3onOcG80hKIZ+SbKfShUNlEg?=
 =?us-ascii?Q?81M1VXOuMQ4BBCiwt40Jc6eE/02i/udy0Fw5PblRmjvxrgSFSwNBZTShiwpO?=
 =?us-ascii?Q?gxgdulGNXk+L8wT+7tK8+bksxVGzAWGtmUDwL71yvVxFg00xGK/c+5sYxGIU?=
 =?us-ascii?Q?n5Qx0xRqZERK+HIpKeQlO/gNKogFrmzGJmwTxxiqDiRpU9BqYC/76QrJEVTS?=
 =?us-ascii?Q?vt4Gj+rsWetfOoDU/SPcCVCR11YivFDJM9Gf1WeRmzNMNtdYsIzlSonZbGnZ?=
 =?us-ascii?Q?KjUuRMipuQuNxNA9kxAvLrVUPRJlqS8Hk5uHO9o+0IQNXb/nTcG7m7SH8a/c?=
 =?us-ascii?Q?ZckL5mTSjoZqb24DA6drGJpMYqVGGnuwBliTswLWlLpkTenyEjhfzBYqZS/y?=
 =?us-ascii?Q?UOREklu5sQlUk7MxJpGB4l2KHpKTji8W/2W9RoTQ9WO016Cnye+k4G7/wPKd?=
 =?us-ascii?Q?LXv/6adXQZ1FOEVpwyH80PKdwVvwvN4lydlRVaAfb6nkCTbCBblX5K7uiZAd?=
 =?us-ascii?Q?NFkEpZkA6Z3NktwMKTePq8MM4AXnvDNgq38uXo3SSYzesRCtKLFCXYJdFlg5?=
 =?us-ascii?Q?TmBzleu+wGeOCBs08zDg6xCmqcqVUyWpXAkoD1czH8DAPBVDPP+zRqwMJWlr?=
 =?us-ascii?Q?/Qf4S5SsD/qMlO1EXBwsufunqb6ukv2IvaffHdkXbvZNdK+ueOWLuQONQzao?=
 =?us-ascii?Q?kEdd/oArXBzHojc12rmUj12EQp9ctUm1WBkvwkkEoIRWndv3NyNXqI+vG9AQ?=
 =?us-ascii?Q?INgyPdBXH1xbr1mBbtZ9yZzav6/hnXIyhzFbXZSDbguCoVumPhWWIVKI48AG?=
 =?us-ascii?Q?vSqs2WpojE665PWa3DuP3kHtqCwARy7sOmBzVBC7N9ffuLkMOznc09fbWbyT?=
 =?us-ascii?Q?IiCv5QmFlf4sMYrNEYrOY1vkiIUM1JJBrz8vdHNBTPRcq5vJzeyB4yCR/fiS?=
 =?us-ascii?Q?I83PY/aGiQSXStM2CXb0Wv20F8Vht2HYx2cNwcBPvEYZdj6K2OX3uuMBkp0T?=
 =?us-ascii?Q?Z6UFXfwEEGKsJsrrEasoxAix?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59A7FB2B93D952448F5632EC723B7FB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdc25a7-f572-46eb-addb-08d9931e818e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 16:35:48.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoeqF5a3pCmWY2Im+GYHZRReOpNnALqqkDTF60v5inlT71rj7FQ9rwHLgLp/HHBS6HDoK10bGOEWmjHWCAGtIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3461
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190097
X-Proofpoint-GUID: iKQK_7je6kQ0TRJect64oOBi8zjLFCM8
X-Proofpoint-ORIG-GUID: iKQK_7je6kQ0TRJect64oOBi8zjLFCM8
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 19, 2021, at 12:01 PM, Olga Kornievskaia <olga.kornievskaia@gmail.=
com> wrote:
>=20
> On Tue, Oct 19, 2021 at 11:17 AM Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>>=20
>>=20
>>=20
>>> On Oct 18, 2021, at 6:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail=
.com> wrote:
>>>=20
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>=20
>>> Add a tracepoint to the CB_OFFLOAD operation.
>>>=20
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>> fs/nfs/callback_proc.c |  3 +++
>>> fs/nfs/nfs4trace.h     | 50 ++++++++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 53 insertions(+)
>>>=20
>>> diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
>>> index ed9d580826f5..09c5b1cb3e07 100644
>>> --- a/fs/nfs/callback_proc.c
>>> +++ b/fs/nfs/callback_proc.c
>>> @@ -739,6 +739,9 @@ __be32 nfs4_callback_offload(void *data, void *dumm=
y,
>>>              kfree(copy);
>>>      spin_unlock(&cps->clp->cl_lock);
>>>=20
>>> +     trace_nfs4_cb_offload(&args->coa_fh, &args->coa_stateid,
>>> +                     args->wr_count, args->error,
>>> +                     args->wr_writeverf.committed);
>>>      return 0;
>>> }
>>> #endif /* CONFIG_NFS_V4_2 */
>>> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
>>> index cc6537a20ebe..33f52d486528 100644
>>> --- a/fs/nfs/nfs4trace.h
>>> +++ b/fs/nfs/nfs4trace.h
>>> @@ -2714,6 +2714,56 @@ TRACE_EVENT(nfs4_clone,
>>>              )
>>> );
>>>=20
>>> +#define show_write_mode(how)                 \
>>> +        __print_symbolic(how,                        \
>>> +                { NFS_UNSTABLE, "UNSTABLE" },        \
>>> +                { NFS_DATA_SYNC, "DATA_SYNC" },      \
>>> +             { NFS_FILE_SYNC, "FILE_SYNC"})
>>=20
>> Is there no way to reuse fs/nfs/nfstrace.h::nfs_show_stable() ?
>>=20
>> Btw, I have patches that move some NFS trace infrastructure
>> into include/trace/events so that it can be shared between the
>> NFS client and server trace subsystems. They might be useful
>> here too.
>>=20
>> The generic FS macros are moved in this commit:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-more-tracepoints&id=3D495731e1332c7e26af1e04a88eb65e3c08dfbf53
>>=20
>> Some NFS macros are moved in this commit:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=
=3Dnfsd-more-tracepoints&id=3D24763f8889e0a18a8d06ddcd05bac06a7d043515
>>=20
>> Additional macros are introduced later in that same branch.
>>=20
>> I don't have any opinion about whether these should be
>> applied before your patches or after them.
>=20
> It sounds like, if there was already a show_nfs_stable_how() that I
> could call then I don't need to define what I'm defining? So if I
> apply your patches and and then my patches on top of that, that seems
> like the way to go? That depends on if your patch(es) are ready to be
> submitted or not? Alternatively, your patch(es) can fix my code. I
> don't have a preference either way.

I can post those two now and the list can decide if they are ready.


>>> +
>>> +TRACE_EVENT(nfs4_cb_offload,
>>> +             TP_PROTO(
>>> +                     const struct nfs_fh *cb_fh,
>>> +                     const nfs4_stateid *cb_stateid,
>>> +                     uint64_t cb_count,
>>> +                     int cb_error,
>>> +                     int cb_how_stable
>>> +             ),
>>> +
>>> +             TP_ARGS(cb_fh, cb_stateid, cb_count, cb_error,
>>> +                     cb_how_stable),
>>> +
>>> +             TP_STRUCT__entry(
>>> +                     __field(unsigned long, error)
>>> +                     __field(u32, fhandle)
>>> +                     __field(loff_t, cb_count)
>>> +                     __field(int, cb_how)
>>> +                     __field(int, cb_stateid_seq)
>>> +                     __field(u32, cb_stateid_hash)
>>> +             ),
>>> +
>>> +             TP_fast_assign(
>>> +                     __entry->error =3D cb_error < 0 ? -cb_error : 0;
>>> +                     __entry->fhandle =3D nfs_fhandle_hash(cb_fh);
>>> +                     __entry->cb_stateid_seq =3D
>>> +                             be32_to_cpu(cb_stateid->seqid);
>>> +                     __entry->cb_stateid_hash =3D
>>> +                             nfs_stateid_hash(cb_stateid);
>>> +                     __entry->cb_count =3D cb_count;
>>> +                     __entry->cb_how =3D cb_how_stable;
>>> +             ),
>>> +
>>> +             TP_printk(
>>> +                     "error=3D%ld (%s) fhandle=3D0x%08x cb_stateid=3D%=
d:0x%08x "
>>> +                     "cb_count=3D%llu cb_how=3D%s",
>>> +                     -__entry->error,
>>> +                     show_nfsv4_errors(__entry->error),
>>> +                     __entry->fhandle,
>>> +                     __entry->cb_stateid_seq, __entry->cb_stateid_hash=
,
>>> +                     __entry->cb_count,
>>> +                     show_write_mode(__entry->cb_how)
>>> +             )
>>> +);
>>> +
>>> #endif /* CONFIG_NFS_V4_1 */
>>>=20
>>> #endif /* _TRACE_NFS4_H */
>>> --
>>> 2.27.0
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



