Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB1521AE0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 May 2022 16:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbiEJOCb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 May 2022 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbiEJNyu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 May 2022 09:54:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074D2A18A5
        for <linux-nfs@vger.kernel.org>; Tue, 10 May 2022 06:38:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ACiokj019308;
        Tue, 10 May 2022 13:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s/thHPgWa+7IN8zjknCrKM94e+aad5Ay6kzxDmV6vpY=;
 b=xY+u4KmhWE4O/vJuXgClkfQakZ0dp4zvOAdt9T7CU5I3DjgQ7s8yGHlCRajdJya72rW5
 rcX8X3eGatU8/eShm458iOrbxLHc7igvQaGqYHymvsUPUYmO5pzOjC5Dgm79uknhZCNX
 8aWD/4ziJk6rLv3M4DwjQpee8dfK2Q5h6l7mVR+cz812unz4gSERzHP+fSURNcEB7kLx
 q1f1sx1rBLydMOE4PjoNH4DY4UmrnegzW7pTzCChTnwZURb55QJZxQe1eV+Tz7oT5hNY
 1OEEtKuQl20zX88lGCSD5ci7YwCtZxgmSweNR0Jd4hkjxkUqz3n2Fwj4h17tK2beX+qy 9A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9pes6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 13:38:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24ADVK2C033110;
        Tue, 10 May 2022 13:38:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf72a92x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 13:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1YjlZzwIhGc7JtWkoWYB6syNFlHgiKq5/nUfRZFkotUOD/LH9HYHHke6gWQMp9fkyXH/LEMcPpkVxQjFqeysbNJN3U3tQOtefCnpWAXO6DzS3dAKZ+LuOYOkSpDMUGBcimr0rZAszjyhz5SMb+FtOrVBZTAl/3cqZGSNCc+OMt38Is5QeBGAN+Rc2kxZr8c6c5mtOUCNfD3E2Kng4upRNKGZMVQDSidof9jLhgPSH47iRlNRdCGitHALda693o5bfMvKO3Aw1px00w4xH2FZ6K8XL2vRWIZfpdHHwqLbx/sR5AcfEMbioPotjUWVAQ0wPq40la5DRDhCKHqcVXfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/thHPgWa+7IN8zjknCrKM94e+aad5Ay6kzxDmV6vpY=;
 b=bmQlr5YCs0OHHD/HgAXln2juzV/hhdwiWgJaEE3r1lTWqutvE/eTrgkkgfFOhlSUGw81G5rHX22IuS5WJmhE5/Zqr1wccB7KiavjBYu37lE3jbyCEmI5Zfj5c6agAGF0lFmzwq8zt3fffJk/C+YzUnQ1VUwev7+u5plogj/jT4IT18+hp2dvk3O6tAMq59kfLZ16gkKjGr5tr0+r3uk18u4J2yqqik/byBubQ0ImwtoAk3EIFzArPvx0VZ4Pgma52llvSkw1DRuTpZAWEPWRB0uYCpwrcR2KCPP0Q9TjcqmaIvY3HkjAG+2xwSxFz3vYBQwEuJvwwtqZugk/c0wF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/thHPgWa+7IN8zjknCrKM94e+aad5Ay6kzxDmV6vpY=;
 b=hr0ygC6lVRPQSxUrviBFGq61SgoPjNwHrlY8OxoBR8IgrowfAuiPUjEL/JlqpXA4iRrALRA99fePpGOZuS7UfoGRK18w20W82PuXWt6QQjBsnkmJOgs6op8lRiWFqt5DWJF0vYdwyoGjKtMy7WS1US1SAbouf/N6082f6+4n0IQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4234.namprd10.prod.outlook.com (2603:10b6:5:21f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 13:38:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:38:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Topic: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Index: AQHYX9vL0QvoWl04KkqOdhnLgfmokK0Wy9AAgAFACwCAABrSAA==
Date:   Tue, 10 May 2022 13:38:14 +0000
Message-ID: <73B0E604-D839-4F66-A19C-2C2B4CD57DEA@oracle.com>
References: <YnK2ujabd2+oCrT/@linutronix.de>
 <11F8D1AE-EB3D-48F0-A586-563165640AB8@oracle.com>
 <YnpURpp14qNi7TnI@linutronix.de>
In-Reply-To: <YnpURpp14qNi7TnI@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb3407eb-3c45-4b0d-c3cb-08da328a5575
x-ms-traffictypediagnostic: DM6PR10MB4234:EE_
x-microsoft-antispam-prvs: <DM6PR10MB423499E17F45DBC23F24E6BE93C99@DM6PR10MB4234.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wiiu0072cgdxQTROkdjUkfhcW2KhmhBUoyBxBnaD7m0OpiWxX6CIAu/0qT6a/gxai0OcLTnWo7+t2UeUf2gb+rdUhLNTWrJvB1wwoCk9oEruLAdPfZGrpSXq1tvh/7CLhkpM8R6otFZv5YC+8lmcrn46NGU3Blg64qww9V4+6rWaCFIpl6bFsJS8Fc9eKHcxyq43XFwRnrEUg5kazuJf4Q+2dML6dmSkknziFUvuQiYGLrU4OHjpvR0exi2JVwxfeZ9eC8+WEk2Q2+h/54CEoxnTPIRmHb3b+eyqU0pf74AgyCz2kRSXkgy3UNC63Q9wi81QPRsITfrbstuiN6r1ELtG97+iV9hS7MSAJsViubCUsTEWgmOo4Su1cqd9+/PkuG+zy5rNoNr7acRQltV3J52cL/DRZfyiyLzBqdkoUrMo7nXZo56lRNNcNyEOKmMuMx8S0ehCpD4EgedGv2rd/2IZyiPCtPQ5E5drsRU9B+ebGEDRU2dA7nFeIFgEuq2Y/ysDxxG4ANFgubtE74N4VUzEobV+gOdmSPzWihgn3sOvMcqkxYWkoy0rcRCTpfT7BxC0hzl3b/TQeduoiBGqFVCD6lJaPKCkJcwebnv2XY1cjVThuRrGR66yEYdnlledICIkoyPgr9ZD3EL3UAyLPO+IsbNOMUxPeGfa0UVXl88ygcccAht9EIsN7nsFyEB3mxUuo+lFnnqUS/b4CkHN8/4KdT4b9dWZrYr3VZKkyIHgUR2N6KmmBCjjX4gfUPEj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(86362001)(6506007)(8936002)(33656002)(6486002)(53546011)(2906002)(83380400001)(26005)(122000001)(38070700005)(71200400001)(6512007)(2616005)(38100700002)(316002)(186003)(66946007)(66476007)(54906003)(91956017)(76116006)(66556008)(66446008)(64756008)(8676002)(36756003)(6916009)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GsipiyhYafZS3uwCcw4JtgdlpxOC5i+Z7jeAIKwVCG7fZ2jCkVha0k9YPHco?=
 =?us-ascii?Q?SyLshubl1zXx8gqy/G0b+1nGVJNdMK3lbnqjvKVHnWO1TXcLmoCPGVDWJ8sk?=
 =?us-ascii?Q?a6BiOWCmY8DYExYWyqY4n3xNMz1att9rN+a4q4UPw5VbbZuCfRDpmbfoDkSm?=
 =?us-ascii?Q?3AXBbZ2agfPc612YKqO9kIDW/iw6IF8A3gd5rTHN4p95ChjAgnvZfuXkC1a3?=
 =?us-ascii?Q?wn5xsOMf4ZDxSW11oGSKNSSPvzwwqd78PZRhY0fahtivxwsGAg0//ASahKWJ?=
 =?us-ascii?Q?SmBafsJpSiauya0IzMlYvurNg5VePs6wxcOLGTlhkyTXyVohLfxkrYQTWnlO?=
 =?us-ascii?Q?Mp7lmR1+kz55fxXOSjckr6SMUFVuLlGnymgaUIf9zC3KkRaXcwTPjq6RcgNp?=
 =?us-ascii?Q?TE5mcQrt7eWsnGOuSMVRas8toS5Q/LK5tQX/MAlJPcfsAetHgdSUPS1Kqq0i?=
 =?us-ascii?Q?/REmxy4SbVhNxin066zBItFelqJ+G71Ld73owaCvvQGju5nt4BkcvJUnzSMx?=
 =?us-ascii?Q?uvddxCnGkwKOpUXCGnijrSzIoVxNGj12J6DaIaaUxJZpvPhH+gP3lLYj1oWt?=
 =?us-ascii?Q?rbTsPxi9fyKxErwzX0JgbqnDhmtkRsj8qOzZhJt0ybbP9ajqCOXEmFsWUmrV?=
 =?us-ascii?Q?iL5PArrHDHwFCXshQnbSkrb+ex9jppRVcFXvyzRYMdNeAOAWDQV9ob6x8YQ2?=
 =?us-ascii?Q?eymS3GaNJOqWvBp09A/zuTc6NBaBDEMJnWZAnQnwu+9Gr1sBKtPL6aUDfooS?=
 =?us-ascii?Q?xlNDnctF/DYVpP/XoYBZlvmZ3CyyvINO4zEdAVub0t+eNNBYD5vmWdE6/qX2?=
 =?us-ascii?Q?86pdOP1Hg/stHH9wR56PfRlm2PeW3rntjcaMNQZYR0jL4quqIq4jp5Z+MViu?=
 =?us-ascii?Q?1NhPEyXLX+7dmpT4rZfofZLPPN/u55tm9ItGP6M1vnZ3+7SMLnBdagPvDS54?=
 =?us-ascii?Q?6CLUGa86yhbHKsdffNdyY9q0qx2msRgY/cpnTCHbBg0itWQjJdo59QDCLLhg?=
 =?us-ascii?Q?Wwzf4EeGtgHJ2a9TlMQVPaZlSD+TTcswnL4qDhhjWeFrD4VZiOXnUVPs31os?=
 =?us-ascii?Q?nGdrobhR7tz1ezu5ZZ0ciO95AeWoO4GtVYzZyEZhrVS2Z7R/xHqu4FEN2gKB?=
 =?us-ascii?Q?Oez9HaN2AA+wuHTOoqlItLEhC6KQ5hPPEp8F8ZtD75jlVl19/bqhQGqI+30c?=
 =?us-ascii?Q?SVbFBB5QtPQKDDwyTmzw4tuCekcvnsbqg46FwrOfqybYLqRLKzLZQylYnUJU?=
 =?us-ascii?Q?GLX/EuNxOsjSxRgfs8QqclYPTVGHt6iRT0HwPjFkJ2BZ+DXZKpaXDox3bW3E?=
 =?us-ascii?Q?FOh9fpusQG+/ZlCyvEpVkzS+hTO2FqbLaQ3jpFs3AgtLs+a4gbUZT8coF3LI?=
 =?us-ascii?Q?sE0WrRHc/C+/CCRlRvxz3UiIiLxx8cHqB35W0gU98bDsyzKQmGR11Moput8/?=
 =?us-ascii?Q?HdgWVIbSkAkB56L/eccJdorQ06Yl4//XCXz7Rb5mQzF2+3WSgBcIHQX8abZ/?=
 =?us-ascii?Q?R17yU9nSDRiCms/o7YxrUtBDyQV4KrM81fQgFrGbN3pH/CaERDuqPe2CRBVH?=
 =?us-ascii?Q?1Xr3VrLyE1x+rrXH/eYvkn5TUtxJnkC/RyUUfQyACLdG1xW0ab+BJ5xwSCjW?=
 =?us-ascii?Q?8uhc+GgyX+P0TsNYshAeTHm5wl9iWEEpdFKnSCw57WX9sczoo/R1aKM4SwYK?=
 =?us-ascii?Q?M2vaneTD46Bb8DC++tKagTVNCaRbwXNjt1iMO3H1jGDtJ5D1leBTPP7WKAKA?=
 =?us-ascii?Q?adh8VPiISYORhSmE6nqEzWiUL3BZzh8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA32E5F42517EC4F937FB4D979089B92@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3407eb-3c45-4b0d-c3cb-08da328a5575
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 13:38:14.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2vwXOy0nJLSiVxsYg3OHGG+7OVTrjKrGcdxsulEVb3ZsaJQP++qg1QqR04LNjtndqr9OEnAUX4I8LIc1u2UIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4234
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_01:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100062
X-Proofpoint-GUID: zz0bMsdhrv1QVmdfBXbff8-njK7oP-3c
X-Proofpoint-ORIG-GUID: zz0bMsdhrv1QVmdfBXbff8-njK7oP-3c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2022, at 8:02 AM, Sebastian Andrzej Siewior <bigeasy@linutroni=
x.de> wrote:
>=20
> On 2022-05-09 16:56:47 [+0000], Chuck Lever III wrote:
>> Hi Sebastian-
> Hi Chuck,
>=20
>>> On May 4, 2022, at 1:24 PM, Sebastian Andrzej Siewior <bigeasy@linutron=
ix.de> wrote:
>>>=20
>>> svc_xprt_enqueue() disables preemption via get_cpu() and then asks for =
a
>>> pool of a specific CPU (current) via svc_pool_for_cpu().
>>> With disabled preemption it acquires svc_pool::sp_lock, a spinlock_t,
>>> which is a sleeping lock on PREEMPT_RT and can't be acquired with
>>> disabled preemption.
>>=20
>> I found this paragraph a little unclear. If you repost, I'd suggest:
>>=20
>>    svc_xprt_enqueue() disables preemption via get_cpu() and then asks
>>    for a pool of a specific CPU (current) via svc_pool_for_cpu().
>>    While preemption is disabled, svc_xprt_enqueue() acquires
>>    svc_pool::sp_lock with bottom-halfs disabled, which can sleep on
>>    PREEMPT_RT.
>=20
> Sure.
>=20
>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>> index 5b59e2103526e..79965deec5b12 100644
>>> --- a/net/sunrpc/svc_xprt.c
>>> +++ b/net/sunrpc/svc_xprt.c
>>> @@ -461,8 +460,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>>> 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
>>> 		return;
>>>=20
>>> -	cpu =3D get_cpu();
>>> -	pool =3D svc_pool_for_cpu(xprt->xpt_server, cpu);
>>> +	pool =3D svc_pool_for_cpu(xprt->xpt_server, raw_smp_processor_id());
>>=20
>> The pre-2014 code here was this:
>>=20
>> 	cpu =3D get_cpu();
>> 	pool =3D svc_pool_for_cpu(xprt->xpt_server, cpu);
>> 	put_cpu();
>>=20
>> Your explanation covers the rationale for leaving pre-emption
>> enabled in the body of svc_xprt_enqueue(), but it's not clear
>> to me that rationale also applies to svc_pool_for_cpu().
>=20
> I don't see why svc_pool_for_cpu() should be protected by disabling
> preemption. It returns a "struct svc_pool" depending on the CPU number.
> In the SVC_POOL_PERNODE case it will return the same pointer/ struct for
> two different CPUs which belong to the same node.

Basically, why would bfd241600a3b ("[PATCH] knfsd: make rpc
threads pools numa aware") use get_cpu/put_cpu when
raw_smp_processor_id() was available to it? Looking through
the commit log, I can't see that it is necessary, but I
needed to convince myself that it was just a coding whim
and not done purposely to protect that function.

And, note that svc_pool_map is a read-write data structure.
I needed a little more review to convince myself that the
data structure cannot change once it has been initialized.

Third, my testing so far shows your patch does not introduce
any regression.

So I'm feeling more confident. Let's do this:

- Get rid of the @cpu argument to svc_pool_for_cpu() and
  do the raw_smp_processor_id() call inside that function.
  Please add a kerneldoc comment for svc_pool_for_cpu()
  that states the current CPU is an implicit argument.

- Fix up the patch description as above.

- Post a v2


>> Protecting the svc_pool data structures with RCU might be
>> better, but would amount to a more extensive change. To address
>> the pre-emption issue quickly, you could simply revert this
>> call site back to its pre-2014 form and postpone deeper changes.
>=20
> You mean before commit
>   983c684466e02 ("SUNRPC: get rid of the request wait queue")
>=20
> I'm not sure how RCU would help here. It would ensure that the pool does
> not vanish within the RCU section. The pool remains around until
> svc_destroy() and I assume that everything pool related (like
> svc_pool::sp_sockets) is gone by then.
>=20
>> I have an NFS server in my lab on NUMA hardware and can run
>> some tests this week with this patch.
>=20
> I'm a little confused now. I could repost the patch with an updated
> description as you suggested _or_ limit the get_cpu()/preempt-disabled
> section to be only around svc_pool_for_cpu(). I don't see the reason for
> it but will do as requested (if you want me to) since it doesn't cause
> any problems.

I think I'm convinced that using raw_smp_processor_id() is
safe to do, and it is certainly preferable in a performance
path to not toggle pre-emption at all.


--
Chuck Lever



