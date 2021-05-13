Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA737FC15
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEMRHA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 13:07:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEMRG7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 13:06:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DH4bIP052474;
        Thu, 13 May 2021 17:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=elfn5YsUOHuV5QqBUL/9+vzd30zSgESUQcGmnm8SAbE=;
 b=R3kSUyA8vno24NGdHjeFiBGMEt2druTiWkFWF8byJ0LM9BJXtg1kEN8ohAMNcZXoVQ13
 HLyofvrlR61IEEUy1OzQs3VQlO1RqPhiIX7GQbYfhCLpP7B/pa+ElotsY3dppxaniVJk
 8ZhA+hRcxu3JW2aLvRDvYr4FKJs3Wxjor+EairZe2dDNFKgRVhWxRyeVcujTaIlS5Z/l
 4ZcjchrB2NRFGyxvWMqVViOa5V6nLf0iKD4jk+EkXW10hGtaeaBEKjDlm21reDFeMGqW
 xmJAbVsBsVp2rYrQnR48g8egt2MIN77suiLlrp9mWo4qV75CA0IvVZN/Zpd7mx2ra5Ue sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38gpnxt9j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 17:05:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DH0vb2063606;
        Thu, 13 May 2021 17:05:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by aserp3020.oracle.com with ESMTP id 38gppbsvcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 17:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIhe1Mu8xSbry0Grt0tH0v6vfFQPvha7+wGEgC782YwpGgHaZ95piMsp/DHP4/sVjkgEohkaHO1JgLf8FzvTht5TiH1ooZs+qIj0XxW9qfniqu2NIqnHGiqRep6IrzYm7DijwHHqtArHD3NUZ0PR9IAi9UVigW7jhOv8SBRlyKZonF1Ds6yovn240OLOzo5klvcFxVq3nEZK/tODYhpvj9GrzkXHzWEPr3rEm2+I79XOR9IA6UZgR7MqsHANm7IvaEgVX2a2L0lHkIWN9LIMzGRdJvL2l3M0w7EiVrhU1843e0gwW0wHku/cvBoVCiZEujvH6NvOHOaeskkq34a5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elfn5YsUOHuV5QqBUL/9+vzd30zSgESUQcGmnm8SAbE=;
 b=YhvtDzZlY41LKwp53QEGtRNkOoG9mOBZHWqPuKHCFsyoCUrYneWYpm8T0rZcdI9487Cqkx1fW6wt/bGqpL+pne9f4cyjoJSYs3ngBIPWtMUNPfMfC4sXGCJwjUYtFsQlE7kBw7U2oq8DNglMzEJBgKdJEFYc+7azO9Xwsi6nV8sRV4g7zbEyeT8qwtTt42kT63liWiH08yIutPGbPtfSEzbvA9WCgZ9X+CSW0eMTRDikfWNuv9/gsE02NK9EyYwM2TrqpnfyoR4mnbhEI2Guik/DsOlu6ESuSLLLTT41z5fak2Z1/e+I+1eNAPxhkgvFs1kqkuBKYlmn+VEXQqVQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elfn5YsUOHuV5QqBUL/9+vzd30zSgESUQcGmnm8SAbE=;
 b=Y7jC7Rcr/yGYOEMmg+WXRuESvHAa5BpOci7gPheMVwtJIRow92u6piulG5xvYh+B/CCj4YAOyw8v/PafplzjKewYBSRCE8RYY49N2sgg2SRG27NSd+UvfLGbknBXzIrenCVSMlRaMqJgg3dg6v3o4m30F58fAMOdfrg2mhkcLKg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 17:05:15 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 17:05:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 09/25] NFSD: Add a couple more nfsd_clid_expired call
 sites
Thread-Topic: [PATCH v2 09/25] NFSD: Add a couple more nfsd_clid_expired call
 sites
Thread-Index: AQHXR0+IZmMB/l0dykSHJqvNU5T0Rarhn1eAgAAGUQA=
Date:   Thu, 13 May 2021 17:05:15 +0000
Message-ID: <46366046-7B94-4B26-A0BC-6B58F8CA5BE1@oracle.com>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
 <162083375498.3108.14242612463783055564.stgit@klimt.1015granger.net>
 <CALF+zOkZYg7RzayueKGwFaE-8sHKTB6g4q_Ej-+u=MkH35Dnqw@mail.gmail.com>
In-Reply-To: <CALF+zOkZYg7RzayueKGwFaE-8sHKTB6g4q_Ej-+u=MkH35Dnqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce8abf35-1bfb-448a-04ff-08d916314734
x-ms-traffictypediagnostic: SJ0PR10MB4655:
x-microsoft-antispam-prvs: <SJ0PR10MB4655A25F6173180D6073668E93519@SJ0PR10MB4655.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RnIboedHqoPQ8gL5EAJ/dmwRoDiPKPXXPNIIObmb1usixEkfplAVRbdndupP0mXbKxL5BmBsvGtpb3ltEMUstvoGVLwel/CTxXRm0M9bJDNhKaZFTpapGlVqMBKyHqO0O+TF0PDve/OSaGnndJMUi6uCEb+q2BhQA0bSqeYE17urKoqI9viwEL9dlJzx7+ppLwz5JMa8GW8lpVFcOz/wB7BlhoXuO/+C0NY6sLfhFw+AhYPHhamxdqo5ABONSx2FQkptN8xfgKfoXEvPMQ1VsMvWgfIIJp/RwQ5aCGnYhIsfuopPd93wBmvs38xGn13XeEjHmRJ53ajkirS10X9rsGwN4JT3bCUSkZ8sIwvZUhtENHb4pOxnvTA/Pdeel2SG3PGV2kzeZPpg4rqcD1XsKjVAGuKHDQCv2nyyUFOe9P/QnNFptIxRJLTl7231zgbwGM1O0FbUriIJmTOqRXHAuzOH/7zd8MbueK7muo16Iw+YjJ+5HtU93BLYlTl7/UvMYPq4A/zNg28XI6WRExViNAptY0PmT5vIt5R03E1mT02rEZ+pdD9dKIGCVqE2+SV6WL+g8VlLDzG8ZTZ34BITUUjf2rKY/56CqpNfyCAH9v02QyzXtaXjTTwiPNfJFFLTOKrqcRZLx86xUucJdoiyTuandKFnm1zetjgRQPKahA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(346002)(366004)(6506007)(5660300002)(186003)(86362001)(71200400001)(6916009)(83380400001)(54906003)(6486002)(76116006)(316002)(36756003)(91956017)(2906002)(38100700002)(2616005)(122000001)(478600001)(6512007)(33656002)(64756008)(8676002)(8936002)(4326008)(66556008)(26005)(66476007)(53546011)(66446008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GikdnrtqlUC8kabRdYvXtmAAeJgl363gnN2kCfjMCuUE1xKaUhskn1dS5Kvt?=
 =?us-ascii?Q?fhVtJgXMihbrUJ1g13+1gsrYSkKFFotJpM5sFlC45Tkc7+kEBB5G5qmOTJQs?=
 =?us-ascii?Q?x/X5IbgV0IYxuIOZppWBRZwOCZsK0dly5Wc34Eb1wN1pZCxAb5jHoPtiwmnI?=
 =?us-ascii?Q?2g09yPgQXAA4E9xvLgPUYUvPXKzOltwJ/rXjAdxBL/wh4vSNc13quczoJq8j?=
 =?us-ascii?Q?5fa3/BDm/fDN7xpdjlCIytscNt6Ms0HjOULGQCXZEJu9dXYQKDbdPA5/JtTv?=
 =?us-ascii?Q?r4x5VrbvqjmL/o/AmkmKDOtiIsnXu+lKkIGK02bJp1CYkHXI4Wv56c3OASjm?=
 =?us-ascii?Q?biE6e/DlZseVx50zFyJFn5wNN2PCA/+49YuuPUROYL+kfGbKsFRQmNN3npgv?=
 =?us-ascii?Q?bc1GHplV2WUYHwyWn/pzvQxK6piIVyB6UTMm9Khh+ntFIiqCcUIe3naOeX1t?=
 =?us-ascii?Q?Fg92EOvCns78jCeqBSqei6ADuh/Gfo6HQE2NaNr/LZt93nHS25uq4ZabLE49?=
 =?us-ascii?Q?+OSeUd1SFaB18orgaPbvzJ5a67lBsVlMRJ1gp57R16oknvrQc7gwT+Dbrfei?=
 =?us-ascii?Q?FX/ITb88ZygkoN1aZ6hTrO2e1ujigiLlmbN8Io5NZxAsN6QD60+6AmA4cf+v?=
 =?us-ascii?Q?keeTQHZ/bYC1fgcJFT+SvBLcr0YWCaZAxgHQu+Qe2ZRQKVCbKjL4b/R3PS7D?=
 =?us-ascii?Q?QnxBNsG5BL17dh+CuYL1fZAzCsQNT3rh6F8bNDfjaNA44AzgkR8JuathXT0o?=
 =?us-ascii?Q?qRd3Le3VeEBQpyYD65j7THtVXoCddkegoiV0sIPK0oBp//Cjg5K/2m/+h9Wv?=
 =?us-ascii?Q?0e0sAMdNj58A7OsJWrqbLvqWyDTDzivo/7FZN3qcWAkur6FzNqglZguMq1AB?=
 =?us-ascii?Q?z20J5JrTtOn17pNdXlydh9n9r5yodOK+R0ItPrRGKUpJAVGXpPxUxK6avJ7R?=
 =?us-ascii?Q?Bzou0nHy7CoJcAlHu+KzlJc8id4bfXv1PAOL1k8dAQvLtw8EOjIkuPH8+Pv8?=
 =?us-ascii?Q?XX9OaGfWn9fISrGbswDwhsgVYNoV5gSyvHpiGtanL0/kgssdtAmcPM9n77Aq?=
 =?us-ascii?Q?MoCf7/F4hs8Z9ubWzlhELi5H/llkNRDVMIoG94dd9d5HR/R38Q/Sh+rDov7d?=
 =?us-ascii?Q?t6bdWMoTF/W7nVoUn79U5gzTv59MlZL2bg7zfkKnXmIK3tR6NUcR7oftOBbG?=
 =?us-ascii?Q?CYsYLZ9qX0UT9JyHnrOFNBdRKgmR8RgTbRtQEUsad83uNzku7V3LtgC2mICW?=
 =?us-ascii?Q?vETl8HTGoh318kBRnQphV88ILKD7E5NZt9uKVpfowBo+o+Vv5WIscL2tOWeo?=
 =?us-ascii?Q?QW0oJhcCpbyxdfIQUwwexLmV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68C53F1C180F7949BCB1B2A245591B49@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8abf35-1bfb-448a-04ff-08d916314734
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 17:05:15.2689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bD6o8dJdH6e5iXIPLQABeH3r6qriqCJ0b88SQgbTkhbBwL0pC7deR/pQdIUx+6yF1KwJTk6k3ngTBSVQIhg+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130118
X-Proofpoint-GUID: 7Me71tauIKr7DK3Qb_7zSi6YiM6m_63s
X-Proofpoint-ORIG-GUID: 7Me71tauIKr7DK3Qb_7zSi6YiM6m_63s
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105130118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2021, at 12:42 PM, David Wysochanski <dwysocha@redhat.com> wro=
te:
>=20
> On Wed, May 12, 2021 at 11:36 AM Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>=20
>> Improve observation of NFSv4 lease expiry.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |    3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>=20
> How about adding a parameter to explain the location of the expiry to
> make it more slightly more readable?
> Below is an attempt at the two added here, I think there's one more
> not shown though in nfs4_laundromat, which you could just use
> "laundromat".

The usual idiom is to create a trace class, and then create a uniquely
named tracepoint for each call site. We already have nfsd_clientid_class
so half the work is already done! I'll look into it splitting
clid_expired into several tracecpoints.


>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 08ff643e96fb..7fa90a3177fa 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2665,6 +2665,8 @@ static void force_expire_client(struct nfs4_client=
 *clp)
>>        struct nfsd_net *nn =3D net_generic(clp->net, nfsd_net_id);
>>        bool already_expired;
>>=20
>> +       trace_nfsd_clid_expired(&clp->cl_clientid);
>> +
>=20
> trace_nfsd_clid_expired(..., "admin forced");
>=20
>>        spin_lock(&clp->cl_lock);
>>        clp->cl_time =3D 0;
>>        spin_unlock(&clp->cl_lock);
>> @@ -4075,6 +4077,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>>                                goto out;
>>                        status =3D mark_client_expired_locked(old);
>>                        if (status) {
>> +                               trace_nfsd_clid_expired(&old->cl_clienti=
d);
>=20
> trace_nfsd_clid_expired(..., "setclientid_confirm existing"); /* found
> an existing confirmed clientid by name */
>=20
>>                                old =3D NULL;
>>                                goto out;
>>                        }
>>=20
>>=20
>=20

--
Chuck Lever



