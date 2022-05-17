Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37BB52A432
	for <lists+linux-nfs@lfdr.de>; Tue, 17 May 2022 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348302AbiEQODX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 May 2022 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348429AbiEQODE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 May 2022 10:03:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2B4D9DD
        for <linux-nfs@vger.kernel.org>; Tue, 17 May 2022 07:02:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HDnthF027111;
        Tue, 17 May 2022 14:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9X6Sw2AP5s6truxgNSG9gwhVIcBghLY2rzbhEIGRMyQ=;
 b=p6I2Cxkvl5et7WW2lZKl8xJqnEvMuZUBxukGPzN5EbR2TvK0/hVnlS8sWFnvAr3KMV7d
 PhrqedEn3P3ipeHGjgwj1gK0wStgX0ImpKYh/qHFR9ZlG8k44oZET1LNYVath/fAhLXZ
 tC+8FFd+vmff5ina/HwN/ksNC0Z0tBlC3XrKAoin9THBEuLJ7HLqETQifepINSYMqMTL
 6QV5Z7ZNGOZpTJ06P1zMdi9HoIDrQsNv8dWo7oZxDNBuUnmhYFUslX0dDsQsSiyCNqHq
 CwJFcOtkvyyVQg87Qw7luiwe1VqgR2ysNdox05gI+1P8GKGu1n5x1t2cpMZl5TI7qV0A wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310pe13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 14:02:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HE1exW010990;
        Tue, 17 May 2022 14:02:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37cpbqng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 14:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO0V3pFv+J7Ozb/p7Rfx4guZb+fJQEjZeiaZNB+EeHcpF7YYteZzobOMMnrJw7hqruYZF0KywDzoSqRRnsEyEmn3YkIb39nBBaQP9OWZTBuCJl2ATFKOGtps4hd2wV+kALOjxcBtbej/8QA6BKTdjiC8iF8A3Aqo7fQKvxRCkrvxlgYStcO1JqdtBtrNSlhb2wCXBjMPv0Mzs9vNoxC4VBJjQiqjyH5ELLpGGGXeKWFKZxuMd5J92F4XuNBtoHVKBl6J7fIxXh6qKveARTPVFt/E3XD/+lBaZercnclQGR0KjnFFGhnwZXIoIttzJuadC92FwT5Fxphu47MkQ8R0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X6Sw2AP5s6truxgNSG9gwhVIcBghLY2rzbhEIGRMyQ=;
 b=PYc9wa8PTstJwSfMzgRIllTWdyjgxArMgsjyTI+IQMSCyGoQZslxX2yDrST4osLqMJf7R/4HAsLvzhekLwQvojopnjzdrZRSQnrdG/RbPXB6C0XgEiW9ufWxKJqy6nLfZ9qnD9q88e6MSe/YTvpQdkqs4cUUtadqXQy1ngnut9Vaw2mOD83gUPcyqq8dyYh6EtbBsc6l+lZg4KgRURHILb27JmULq+0jI4jme1Qi2TAKZJ+UTmbOQVTr+ILjeXqRGlC9DcSMP/pYr4K+BSTF9y3QE+9UoOQDKJetPDdgB27JEaB5CfmyaewBSLd79xuc+ZM2K9KvEuozEFKe7ob73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X6Sw2AP5s6truxgNSG9gwhVIcBghLY2rzbhEIGRMyQ=;
 b=HE21dHBWNgywn22At+gACVFM0KsDRvLxua/aSmbUgddmgx2lo0S9sWMhrs+VXia4W+70vTi/X4kVICvIOaHZ48ZbxFcKtwfcxs+t+qwtiwLJxrP0xBqLVZXS9VjRD4hpq/5XDbM3PYUcPeF9UqpEcJJduDAiIBs6ur2NCsT/yY4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3423.namprd10.prod.outlook.com (2603:10b6:208:130::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Tue, 17 May
 2022 14:02:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:02:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAIAK/HiAgAroagCAABmggIAAGOOAgAYzNACAAAZIgA==
Date:   Tue, 17 May 2022 14:02:36 +0000
Message-ID: <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
In-Reply-To: <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69cdce43-43af-4458-03a7-08da380de580
x-ms-traffictypediagnostic: MN2PR10MB3423:EE_
x-microsoft-antispam-prvs: <MN2PR10MB342370AB1409914043C4835B93CE9@MN2PR10MB3423.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SL/WIK5ooBWuEEKVuDWV4z+9mbeF1//4hjfYkj/ty7WNfJ8TtF24GSQgSOitYTu7XjN5S5A7XzTYtRVUtH5HaxSca5NMNw3o45a6Q/pTMRmu75qnNWrxQZ90wMclr3PrM4YZYg2kGdRARpQDtC8D/XKbc6gf7L3fQ539CGre3eRNtyIITISfsmbNjuF2+xrwetYLe2xq2gFcdnC9VgVQptqwHw8O67gLDu1SVP2w8wcG3jbP3+5ciIBtm1Oj+Rf5UXafc6V6dl/hXWjkj5T8d2EXfeEHx8KggLuxJ7OHQgVuVbC3+4c1hGll1OPv9OvpMBK9HhsHybdtEq04JoXr1rhjt0TrKv2oUTyd7rtCx/YOHmy1NOyO9we92bEO9fCEiDNB2xgEIVZ9Cke0vtUsypKAoKZ1brCGyBW6wZHJnFBz5UL5dHk4GLzXMY2Fp+4LjOqtyWT2HBp/TE1SAHiKIucPVkil86yllm1Z2Rjr2EnR1saS6oqu0P185ENzbF3PJPevG6NU+QAh9cbFzmR7S4DN2EhQG7Qt7JQRJ71UNarfZiRiWGpOZu/Wskczq/j9ybQMOpwlvbS8aGkzT7tiLG8cos/ItFUc7FPNcbCbYjQJuiSbdYyOx1WtXGJTF3vfMNq1yZ5aY2k2ERUywv9s1ik2YlPpGucFORf0DqSq5a/1/Vgk0S3v4QU3cZamDOMKBXzWSYRLP2UwXDYuXoT3V/7tpd0O7UwC7aAKnz4ZgcnvtCqQiEgJ4gNFWz8bi++x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(508600001)(6506007)(76116006)(8936002)(122000001)(66476007)(8676002)(54906003)(6486002)(64756008)(2616005)(66556008)(66946007)(36756003)(2906002)(26005)(6512007)(71200400001)(86362001)(33656002)(5660300002)(4326008)(186003)(91956017)(66446008)(53546011)(38070700005)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BQqNY3e0nlhPy1qbG10UYzkh3O1IewZx5X9BqJR/oDmaVi1pJmHCyBzBck35?=
 =?us-ascii?Q?nCe98YMWzReZCbf6fZMBb+H4LUs8Wv+qBeT4Sc/E97bOiSCoqKHcSk6CKppy?=
 =?us-ascii?Q?HZtP9YTV5b82hAOizEBDQkT8j1ffAhQXigd9JxSwNTJOlAwGRZ95as/Ie8xH?=
 =?us-ascii?Q?93qntxf+OT8wjb44jNSlRY/rzpFmGkMqeCNgs+0cXNi1LHgsa0GmlzJKa4qw?=
 =?us-ascii?Q?c1pRb03xvcwfMfJSx8FImBuRKc+zPgl0fPq71+gVWtzHSIdWzjhekq2l736s?=
 =?us-ascii?Q?WAPFiIm7SnB7o/SaXyFmLyIJvNlOfvprkH+8gq7nd52oYJ6RIlw27kUXpXhS?=
 =?us-ascii?Q?WAGkYg1zTS3cNLZTvNqQAN07vx5zQNOeaszJje07epHfzpVYdvB/eeZF6Ia/?=
 =?us-ascii?Q?0LxYcooruZ7AUmBX8uRLNcXrlW9SlqZf26sWRFDfC0DAARrW7Tzp7nOIA8R9?=
 =?us-ascii?Q?4qOXebeaehAfpOniomztEDEwt3gc8FfH41LJdauVZe5GbtLcwHE2vFmc98z4?=
 =?us-ascii?Q?E0lVVqAkvHc/Nt/Dwf+lDAbz1sK4ZdVzOSzo5D2GuFIrkW2mA5WlYZ+QKiqe?=
 =?us-ascii?Q?wbaJMuFgsdTxqQ9oF3bfm3wJClKHkIS5A+dfsZ5P8Ac1qs+dBtOK+0F4nq1H?=
 =?us-ascii?Q?9dFhmno+Z8qA34OyLgXO0zww+SC3rD5aHdRc/3quw0S6yuJxza7mctsbFRJN?=
 =?us-ascii?Q?PyqvnhjP80Rl1NnThTaJSTXC4xdzkr8IC7e8UYck2UpH/ORVvgaMIRevERhM?=
 =?us-ascii?Q?OKGcN4GRxRezQqBAi/XfvC03uImlovplqfB+iktOmmQuKJ57IMbN7XynEUbB?=
 =?us-ascii?Q?OL1DraOsoGaqg7Qk9SM21hVrkFT7ynZAPiDAL56o28ziz3dt0f+JJLW7yhFT?=
 =?us-ascii?Q?Y2ACGFeoaQjns+ISHlqbJ61fjs8225Kd+BmvhUJkELCv2HnU7qcj4ReR881R?=
 =?us-ascii?Q?qaJUlw2U8XZGLypcYOsmiXF7R19XmSYIQAYIMqaHGK4LNTjiBB+8CS20pKpy?=
 =?us-ascii?Q?pGpnCNGKyVGUngSITgZ6hzoByXucvbdJNLfGpBg0Kg7tu/rXtC7VM6yHzCyv?=
 =?us-ascii?Q?N2Az2Di6pUTSbyGgFR00uLJfvfr52TxNVw2+vNQclayqZd10osYERqDq33Iw?=
 =?us-ascii?Q?/hwcY5dH0fk3Vag3ANq3QnMCMMlUCQyrFFHnYz3vhNnNj882FZLMDjnPSf00?=
 =?us-ascii?Q?insUuytSucqhNMWhQVbI9qnx0aSLzOGQV+3X0BtIT7BEAXGc6RdbqzWjfn4B?=
 =?us-ascii?Q?sNsSMrWEbjzvOoHzKDwX6BtGLrHgHkU/XVEO/Sc4TqaUu6kj7K86SlauEOKZ?=
 =?us-ascii?Q?xJ+ZH0P5kZ6lVY4ZUjUe4Qyr7aX3hyxUVSkiPgjayi5MXS0o9I+EU1r8pFMG?=
 =?us-ascii?Q?PM/MwYzECNaVOAY/33wbZXfQqM6k3FmZtY0xrzR0XgGJMMvBvFpSG4I9GGUj?=
 =?us-ascii?Q?0bjUI4ku2Fku7Y5zC1mB9+MmeG6YTEnIvUh0/D1E4xrc8j9aC7iXpIyajEPS?=
 =?us-ascii?Q?lHkefnA286/E0SHjfonZVTle3tOVtYU5ET0dPFGfdNr2JwqsFT240I/6HNT1?=
 =?us-ascii?Q?LGi2gNg1qRjTnytjYjvqwXE3b47ZMm3SWmKoxWZUbCpbIdsq3gax4gejGEnW?=
 =?us-ascii?Q?sqKssJAGzYpaPie9dWnD1f+pNIfI757MOgNy9N65uL87z/Uh9XsKFwatpx74?=
 =?us-ascii?Q?CxgY01/6v5wH7WMv/5wuUOhe7rSU8C0t+1r1OcrwMJsdf1WgTd7KJyEwZ6zT?=
 =?us-ascii?Q?zF4QYWham+1Ppt3uIrCIXJpYxY87SZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB2EA7B94A120B47992437BD4A059B4A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cdce43-43af-4458-03a7-08da380de580
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 14:02:36.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW4cKduJzo7WSFz/jABEQE1heDsZFpCUu18eG7vRJxlxyAJhTkbeUp4iaROoFBfkPRD7uJc6XuNlPolXfUfMSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3423
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170086
X-Proofpoint-ORIG-GUID: jAHfcboS6GFA0sPxw5ENKP9OFXqkyJec
X-Proofpoint-GUID: jAHfcboS6GFA0sPxw5ENKP9OFXqkyJec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 17, 2022, at 9:40 AM, Dennis Dalessandro <dennis.dalessandro@corne=
lisnetworks.com> wrote:
>=20
> On 5/13/22 10:59 AM, Chuck Lever III wrote:
>>>>=20
>>>> Ran a test with -rc6 and this time see a hung task trace on the
>>>> console as well
>>>> as an NFS RPC error.
>>>>=20
>>>> [32719.991175] nfs: RPC call returned error 512
>>>> .
>>>> .
>>>> .
>>>> [32933.285126] INFO: task kworker/u145:23:886141 blocked for more
>>>> than 122 seconds.
>>>> [32933.293543]       Tainted: G S                5.18.0-rc6 #1
>>>> [32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>> disables this
>>>> message.
>>>> [32933.308740] task:kworker/u145:23 state:D stack:    0 pid:886141
>>>> ppid:     2
>>>> flags:0x00004000
>>>> [32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>> [32933.324524] Call Trace:
>>>> [32933.327347]  <TASK>
>>>> [32933.329785]  __schedule+0x3dd/0x970
>>>> [32933.333783]  schedule+0x41/0xa0
>>>> [32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
>>>> [32933.343639]  ? prepare_to_wait+0xd0/0xd0
>>>> [32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>> [32933.354183]  xprt_release+0x26/0x140 [sunrpc]
>>>> [32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>> [32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
>>>> [32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
>>>> [32933.376564]  ? __switch_to_asm+0x42/0x70
>>>> [32933.381046]  ? finish_task_switch+0xb2/0x2c0
>>>> [32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>> [32933.391391]  process_one_work+0x1c8/0x390
>>>> [32933.395975]  worker_thread+0x30/0x360
>>>> [32933.400162]  ? process_one_work+0x390/0x390
>>>> [32933.404931]  kthread+0xd9/0x100
>>>> [32933.408536]  ? kthread_complete_and_exit+0x20/0x20
>>>> [32933.413984]  ret_from_fork+0x22/0x30
>>>> [32933.418074]  </TASK>
>>>>=20
>>>> The call trace shows up again at 245, 368, and 491 seconds. Same
>>>> task, same trace.
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>=20
>>> That's very helpful. The above trace suggests that the RDMA code is
>>> leaking a call to xprt_unpin_rqst().
>>=20
>> IMHO this is unlikely to be related to the performance
>> regression -- none of this code has changed in the past 5
>> kernel releases. Could be a different issue, though.
>>=20
>> As is often the case in these situations, the INFO trace
>> above happens long after the issue that caused the missing
>> unpin. So... unless Dennis has a reproducer that can trigger
>> the issue frequently, I don't think there's much that can
>> be extracted from that.
>=20
> To be fair, I've only seen this one time and have had the performance reg=
ression
> since -rc1.
>=20
>> Also "nfs: RPC call returned error 512" suggests someone
>> hit ^C at some point. It's always possible that the
>> xprt_rdma_free() path is missing an unpin. But again,
>> that's not likely to be related to performance.
>=20
> I've checked our test code and after 10 minutes it does give up trying to=
 do the
> NFS copies and aborts (SIG_INT) the test.

After sleeping on it, I'm fairly certain the stack trace
above is a result of a gap in how xprtrdma handles a
signaled RPC.

Signal handling in that code is pretty hard to test, so not
surprising that there's a lingering bug or two. One idea I
had was to add a fault injector in the RPC scheduler to
throw signals at random. I think it can be done without
perturbing the hot path. Maybe I'll post an RFC patch.


> So in all my tests and bisect attempts it seems the possibility to hit a =
slow
> NFS operation that hangs for minutes has been possible for quite some tim=
e.
> However in 5.18 it gets much worse.
>=20
> Any likely places I should add traces to try and find out what's stuck or=
 taking
> time?

There's been a lot of churn in that area in recent releases,
so I'm not familiar with the existing tracepoints. Maybe
Ben or Trond could provide some guidance.


--
Chuck Lever



