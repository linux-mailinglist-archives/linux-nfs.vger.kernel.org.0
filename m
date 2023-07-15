Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25D754BF0
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjGOUOQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOUOO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 16:14:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726912707;
        Sat, 15 Jul 2023 13:14:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FFFmkJ032333;
        Sat, 15 Jul 2023 18:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3hwF2QZ00+3Bpq21HYFAJrXswkkvAX3kgAo3T8epqHk=;
 b=HzTkQg1vRk9dBJ6PNjD0CXhMCcHyLnWz1jUjocujGi+j1/NWeXCaSg5GpouwqQ63qqlV
 jMrF0+hN/ovugUN5+8Jo9XVXlryTyBnk78OxwNHLPFdWR4g4TWdoSckAyEt5Mx4Ezot8
 rRTVTqIrs+EDqUNBET3U2y87aAslhPvjMcdPfyovJWXJahUQg5Uyku6TKg2QuicLjGwj
 M7HHsByOtOhPusEx+22qoVQ0BOpHm7BkyczC48H363zVMxrzbl+tlQw0BtmqJELMQWXO
 9Wg+w+IA2MWank440qf1FC2XJ1cBU46d7tatKrmuwKRUeossE060WjANmceknBx8LZ6O 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run788mqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jul 2023 18:57:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36FIr6ZY007790;
        Sat, 15 Jul 2023 18:57:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw1fuef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jul 2023 18:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llOEbwiD0R3Miu+3ys1MfcLK0CkY8pquMYYjbahnE/y1I09UyYaCjbv4J+C9n+0Vy0d1GoTnNRm2uBBHbnEq4MEnraNJ3A6MZ9f5O+175Wmi/c2Zc448v0GcjqKnGqFal5dFgwgv0tn+zOfaajXnYAi1ipcroy7xNYsUsTqFfS52kzQHwwEzV9BDdM2rX9QioI2wyF+ZDnQPKyyrHNcUc6koR1GwGAFtYzqriu0tgYwlTKG8f1Zd6evIR4JSIvpqPkrO7yVNnAtnPaOUKCzkKDfITjR19eOjV3HBVPpwqj+p34hm7HcM9onHqTIWi5CjpBWCn0aQQk2gsGv82CR7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hwF2QZ00+3Bpq21HYFAJrXswkkvAX3kgAo3T8epqHk=;
 b=Yy2lsir69O2MLSAjWIOT10KSvqhAUUFhEnQrJtHzMKz6o1g2ePLSwS6ncXRA99mynHID2YQXYnZz76uIVf2tXX42HS9N56GM2yip9GAYiWnSv8/G8dJigpxjj40/1u6waptHDl1QfXdHew3GKgX6n8IC6IHqyPwNRD97zY23RBX0jWTbwZM5ayBaEYuywwPHRnMmuSK3Y777uZBQ+plVmvMl4n7wATD8wY0hhKf6XhvinZc4QTSD+LHb33RZ79xM3mq9o6SUqC+bPLUtQAmEJi0nlSsblS8BZg9X1LV74pFmTX5qx8AbSr9LJNdJV/LDKgpUwUxg3pM0aHgdtvYgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hwF2QZ00+3Bpq21HYFAJrXswkkvAX3kgAo3T8epqHk=;
 b=gIpvTlSax5/lODqAkSh8kU4hshfkBlAmqvtd4aUmwhLWNpLLjSLIKSvppzOKrvvMwurmhnt9CNVbkPOuaHfLL1Z843EVdxUFPyHUJqZ+In9mF+3fSGCQbtPW40GWBKFnmbb7GOTnUsxb51N8MoX2KKK2lf8Bs7WoF1uBzDbUBUk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4204.namprd10.prod.outlook.com (2603:10b6:5:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Sat, 15 Jul
 2023 18:56:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6588.031; Sat, 15 Jul 2023
 18:56:58 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH] xprtrdma: Remap Receive buffers after a reconnect
Thread-Topic: [PATCH] xprtrdma: Remap Receive buffers after a reconnect
Thread-Index: AQHZtmXW1KhFMZKe0k63dgGlYrfiG6+7DzkAgAAgMYA=
Date:   Sat, 15 Jul 2023 18:56:58 +0000
Message-ID: <FF1F6B85-A97D-41A0-B28F-AF7A568EEC68@oracle.com>
References: <168934757954.2781502.4228890662497418497.stgit@morisot.1015granger.net>
 <a9f18064-45d4-4346-0156-dcd74e001b82@talpey.com>
In-Reply-To: <a9f18064-45d4-4346-0156-dcd74e001b82@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4204:EE_
x-ms-office365-filtering-correlation-id: efa06ae6-6c06-4f47-4882-08db856543ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlRQ4wRNnLH1eSu7HNEdPe9xiKzQ7KJhoanorc/jqtJBFXmGOwzO8Y/+NaFbGo21+cs5M67hBhnvNX61Xs8AGkOJ5VEG9rlNycLxxECt38RaUzCbbcqUqr0N+9OPd58miH1fTlMKA/tTRUtl3H2Hn5qTvH6j7H7AxNtDmUXdJU9oS3Jgc1w/P/YRfj67qq851yiPVWQcwpG7v6x2FVhLUiWN2iwm+nkHLCmFgHEwx9sJnP4aO+OKE3fYnBTjNHCpOSaAJKd1QRbMNxHLaFG8cpS4Bc6cMGKOWlkXO3qS8J86AaLufKhZAU25pdS2oQnOQotJ1pCKXv0iYgZJF0A6TNmN4C6Gl5ifzuR+5ii0zMCP83KEWnM2QinE+KB6OEmA+XJLUYjx2MI9ZUJVa8X/2f+ZKesZMvvnCtrEowMtiuPbAKrvACdv77NXZrd3moGvzZ6VHnwzNVL3DGs5v2rtPVfkJ4YC1HC8lLK+vq6LnzXsNi54g1ujefDVXyWA9ftRZvvZCYsNtlp+Kxr9MxB/wRUxej704Fc/268sUVLYboy62NI4J4PubsCKD+WsQeKEcwm3cWja4LdUCNPLl7+TgaK+liFrFpp0UcS7ImT36gwPwwwyQAIcxdUxAYsAjTo7ZsQCdPi9BOQZCrF1eLqsuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(41300700001)(316002)(6512007)(5660300002)(26005)(53546011)(8676002)(38100700002)(8936002)(6506007)(83380400001)(36756003)(86362001)(33656002)(38070700005)(2616005)(186003)(2906002)(122000001)(71200400001)(54906003)(110136005)(478600001)(64756008)(66556008)(66476007)(91956017)(4326008)(76116006)(66446008)(6486002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w1x9EAMxiHbAQXE3VODQvdDbPuDvdLc5+Mdm+xtS/6nnWfIGqFbPhtki6dUN?=
 =?us-ascii?Q?LWNWaJB8FuCaiK5ZCsnOoQM5/Y8JGulRIMJzIYvQN5ijpYHAJWhrRmpBjE+l?=
 =?us-ascii?Q?mpYjKMuS5e9eHBb9TfJbESWWg927AIQFGmOHHAoF7MN8RzSRfU7e3VHAsRmr?=
 =?us-ascii?Q?znliFwlYW/C5rckUA8pRpgng7+FgEgyLqTAK9fcg5Kz3LkJXazAOyBgDwk+t?=
 =?us-ascii?Q?a8LJF2jVMMYw8C27KSI+2NXnAiMNuPqiSkaq9kAnQlaVhzkPrdA+W9M2sC4g?=
 =?us-ascii?Q?QXU5o3uNFpbyAubePeV0wJRrkACW542ZAvGPoZeadHETNAuUa9mnb7FI98pG?=
 =?us-ascii?Q?NJp7w58MbDvKWPICw74wZgObonTDijGdTjDY770bIgIz/y0TOxl23EuM+DXq?=
 =?us-ascii?Q?X/6D7ZrYZO7U8ePhgXg3RfIEtu8MnTfJ6cbfo318jI/qaibDLrGkdbGtyUQS?=
 =?us-ascii?Q?zbqnEcSr0rxSvO2Kvg0HP+7FZS34cE7NeaXYxIcqOeGPaWZnlAjJsmrQobcz?=
 =?us-ascii?Q?3xdv+ALaqMKnxQ56qHydaoggvWa/qPXMkaVvBfVn9bdW/ZvvX+pHXCZhs+EY?=
 =?us-ascii?Q?rP4Ki3uBFONBpEI7nkEV7JvJJSR5qZhR3XbS/r5JFiPDbV9DO0FqdWLh1EEh?=
 =?us-ascii?Q?LYeD+xphee/Hvq9LdS5PzNIpEUg1M30DY1VoZ53nMDncBAE9WIcTPm9KUofn?=
 =?us-ascii?Q?gkv0RO8sQGC3QnWrtFUOfA3q98+HfU9u4OLcyru8NtN3sDTTmkhJMfOEqhDS?=
 =?us-ascii?Q?Q1T0jWXeWhz/9hypOrGWn08R8snZrhFsX1ySw0n1i3ftNNQ/dHnG0pVUnwSp?=
 =?us-ascii?Q?YopNyF/rXingNwmrQhG231dq+vIFu9ehM82gXhRGctehQaeGQO4KUkUvXq4K?=
 =?us-ascii?Q?i9LbrCpUaTZ7BC3mxEB3V6GSI1jE6Swj5JgmX0s8BPTXYcHVw42Xbb3WhIU/?=
 =?us-ascii?Q?XoZau031p57Wj3DH3bCAlccbHIGzHJiAmRcH6lnvGxvAOcOm3hOutjIRq0QW?=
 =?us-ascii?Q?GP71uftcQxkb5bsRxHhvbb+8MyIgGTf73Dh+7C+DWQtmSX5tnw93tBCTHUXW?=
 =?us-ascii?Q?+oxH5i7PcRfatR4tE67Pl58bMJk+75Hb4lDeNN1QgoSdvn678GVWP4iI1Wzw?=
 =?us-ascii?Q?hmGHmbR+UlUGHttTMmwPE3b5h24UO9PB7t1D3fEtHrG0zxBslO5rOIeqq37u?=
 =?us-ascii?Q?s/NP4raQZo8ftMLhMRc6pkIwl4daL8oObdUOEMQTyHrCTsGorjPS8/d1kzRq?=
 =?us-ascii?Q?dygN3KLJ7AdrrMNimmHfRYwWsSgyBB348TkHJ1HtIwnVQVDZw2/jWApKOEsU?=
 =?us-ascii?Q?ouMxmk8/yGcuAXl/G9eT96YrrXLyMBC9c/ZlBnej9bGfOrye1RyKRhTp1vm2?=
 =?us-ascii?Q?EVVCvvxOk6NVXWAqJk3w25N183Ih3oC0qp7VVGDJlJxPdpMxVOa4meCuwX4o?=
 =?us-ascii?Q?iGwvKZ+KxkJrjrozaTFcvVZrwGF1GcKZ5bAjbHNL28ux0ZCmKOth0d/NAELp?=
 =?us-ascii?Q?tF+gN91/iVj+DYWK8WqKD6vcvnsfFn1hs6fo/W/VsmLu8//0Gd1Hzf/8DJnk?=
 =?us-ascii?Q?84EAXMYMWEq08w0p36NcRX6SPgV/Q3bUcfIBN9zVibcEnzc19S4f4fUVCw1w?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E19F93939AA5D84A862B7F3FCB0319C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4dvPqDmCcZxZgZClhVlj13GLAi6uy34YRAWrdTXBXoGDiJNYyJkNTl2Q1KbmisdOfBfEDGb6lPaOo478CKoJpEBWuMS1zih0I5h7/AaH+BfNlqV08SyZY1k7sQhl+NehAOpTs+alRH0vBX0FknIAjbqCW90aAUEnbNr4MPSdv7aQtfNjIN51imgHiXaSEScdv0lTyo2CU0i4PDP1L9BirybrUkok0rHV64oRNZ4IPiiHBPIhKlJNiHHqtvVuW5wNoyLCmsJv66HFYwkQrkhJCG2HoKu/pAnQJ22dghEjmwqiEelDlGifvparMKtrOlaRbffO6gcpwM1ubybIsdyUbRfU/SCwzbq9IyRKjLf7bekABu4aARYi9Wb1qLCpGOEMrnoKe5pZ/v4h79tvBY+3VVq1IxaxJAwCVnnapBRLz51W/XLw0sQVIcKLQQ4/L7qs5Fvr5QefGK9YP4dYLGLZmsOkR3t2q764RsNLTPshpnjlLrGCqZM7XhuyjTKWETDDP+jqKMv+TxTDhnoSnZRR/r7PCD/cfChVlwz2234R2QlB4GgZWxX4KSLCxeR62Hno7/JQqf8v0M4j3N4zGr5P/PL0fHCWTaVDOsgGhuReNa5qfLkEjmfFe9sdnJ8F79qxfi9NlPpb880NvX/8JmtIxqTMJf3/HvY0LJKhFX2O8QATfkrtvZOBwOd87Ils2wMJKPooxfXDUMMbR2K9pe94OEU97lo3whK5hk3xJgRi9BEmUgecV3Uh0l96v98+eUTscdFDleZWzGvGIeuFRff93bkJs6TMSNE/7uBUE0v/B9CWVRFn6tKcoS5zJisArnZ7TQ/a9jtPJAxH/G+Ox11R3vtt9GSbmWuSNwZJwwrFPgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa06ae6-6c06-4f47-4882-08db856543ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2023 18:56:58.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LO1Y7SC+M/wGA2ZCz8A8y0DnghLlEuvBHc8trb66H5CXibetj8DqXwsJbzIDpJPuzCKWt5wUvduUhEWLAj+pZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307150180
X-Proofpoint-ORIG-GUID: jSuwe75M2xvxnpw5Mu1Tpqe227_s8h8o
X-Proofpoint-GUID: jSuwe75M2xvxnpw5Mu1Tpqe227_s8h8o
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 15, 2023, at 1:01 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 7/14/2023 11:13 AM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> On server-initiated disconnect, rpcrdma_xprt_disconnect() DMA-unmaps
>> the transport's Receive buffers, but rpcrdma_post_recvs() neglected
>> to remap them after a new connection had been established. The
>> result is immediate failure of the new connection with the Receives
>> flushing with LOCAL_PROT_ERR.
>=20
> The fix is correct, my only comment is that the failure occurs when the
> first message is received, and only the first CQE is a LOCAL_PROT_ERR.
> The remainder of the posted receives are simply flushed.
>=20
> Same result of course! The summary is ok as-is. Important fix.
>=20
> Reviewed-by: Tom Talpey <tom@talpey.com>

Thanks for the look!

Anna, when applying this patch, can you replace:

"The result is immediate failure of the new connection with the Receives
flushing with LOCAL_PROT_ERR."

with

"The result is immediate failure of the new connection with the first
unmapped Receive completing with LOCAL_PROT_ERR."


>> Fixes: 671c450b6fe0 ("xprtrdma: Fix oops in Receive handler after device=
 removal")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/verbs.c |    9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>> Hi Anna-
>> Can you apply this for 6.5-rc ?
>> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
>> index b098fde373ab..28c0771c4e8c 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -935,9 +935,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdm=
a_xprt *r_xprt,
>>   if (!rep->rr_rdmabuf)
>>   goto out_free;
>>  - if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
>> - goto out_free_regbuf;
>> -
>>   rep->rr_cid.ci_completion_id =3D
>>   atomic_inc_return(&r_xprt->rx_ep->re_completion_ids);
>>  @@ -956,8 +953,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrd=
ma_xprt *r_xprt,
>>   spin_unlock(&buf->rb_lock);
>>   return rep;
>>  -out_free_regbuf:
>> - rpcrdma_regbuf_free(rep->rr_rdmabuf);
>>  out_free:
>>   kfree(rep);
>>  out:
>> @@ -1363,6 +1358,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xp=
rt, int needed, bool temp)
>>   rep =3D rpcrdma_rep_create(r_xprt, temp);
>>   if (!rep)
>>   break;
>> + if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
>> + rpcrdma_rep_put(buf, rep);
>> + break;
>> + }
>>     rep->rr_cid.ci_queue_id =3D ep->re_attr.recv_cq->res.id;
>>   trace_xprtrdma_post_recv(rep);

--
Chuck Lever


