Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1965753D9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiGNRSt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiGNRSs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:18:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490292A416
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:18:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFsVUp008512
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1d0rmeYFfxNRFEcoRt+1PzC60sfxs9PE5oXnIEbeNJE=;
 b=BTkgGqm4+TjeKaA0RiRg8K4NyGVDvRlwK+95KJO44IzpurznKn7DPDhFo8GHV3inbSo+
 rYYiUhJueJE4Y27Z6HwF1y7i///x8u7IbQJiCvUIelTW7QqVDT2pVzzTh5nWpjGbPYUz
 zKbKwRWbMpg+/3UCcH9TCNtsDSIqf/+09dete/gwxPi3WVtQndV8o1PnIYjp6Ztf0nt1
 QJZsYwIaFXw0hd6bcdYYX8FC8JMz9DUbbChBtMnP8CsPjeUBIki4Wv4IEV7ZMEDdMOYw
 yo8gbTWXJ2wyOFTm1wwHHXFihzGhSg5MiixKtkmxD92956JqS94T9ZIe321EwpJcQTP6 NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scdycw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:18:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EHBQeV021676
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:18:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7046gw3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 17:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSMGR9hUjFVlcofv7xeJgYuXy3TCTh+NkpQ+HxCW0wEBCZ2TfCzELcnu4p/6bjed6tSd9kYr9RH0BHigXl0qceOY5QBCtKRTrE45iVIAyLy6ZtVU6wO0Ix6AKshxcN3sf+/jUKAx9tTDcw+/q4FBX8wrp3oowneeEQshDrFV2D8X6LdK5fVK8hYLYm8c6U5VZ/aaAIHxzFXxKwYGv83u452nAPpfRBeYoHDu4gEM63Ellu3cXqnlnL+jgO1pyUoWaNGFQbQKlRGZWpIJgDgMh6aDZhhM5jIelp2IHLm2wZ2svyHDJaO2noeBIO0fCEKpszgvZHCH3IC57oRP5x8alQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d0rmeYFfxNRFEcoRt+1PzC60sfxs9PE5oXnIEbeNJE=;
 b=kuP7LWNdjlEMvQPkUkdw9RYkY4WbhJtu2QL2pTRExlxHbol7ANmGcXXNe9rZrEA2jIf5/9tKWPcSKF5yyYRb9zSadXo39kIuwifYKUC1WevErwxKcOP3VzCFKwICAM/HT7kU/k12lsNbtSLr9Y42Y+qIm+DYQOc6EJm8hCwVAtR0zUIBQ4M47fjAudzG5Bb53p1qIlj0+W7ZRehm0xJKHhe7j98gkODd6Rr4HdL7e+gFDs7a56aDQFAP3PsVBY8KnB3rhr54s2uy/mu1KNze3yka2nJPO+GGgSfKfCIT45BX+Bc9ozWXszrqLZ3desZkrZC3aQS9b8c0Z9tcxy2c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d0rmeYFfxNRFEcoRt+1PzC60sfxs9PE5oXnIEbeNJE=;
 b=auY6nvxh5rpeAwXDPl5Ozexmn19AOVTkS66dTOOXrVgiQYbju9u1P1qwc0oz19aTfX6UBzOALsyprn3+NAVLEzJOOUx2sjKaWeZHXoG9oqID76FD2uKvZTXBHRN+4dikYCsZb1L2q7lNBcVclk2dESPU+B8wknFDBHtELC39dWI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 17:18:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 17:18:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] limit the number of v4 clients to 1024 per 1GB of
 system memory
Thread-Topic: [PATCH v2 0/2] limit the number of v4 clients to 1024 per 1GB of
 system memory
Thread-Index: AQHYl51Cor/5vx+r6Eua5pLIAIQ8M61+HE0A
Date:   Thu, 14 Jul 2022 17:18:42 +0000
Message-ID: <86EDD9A1-CB3D-4E3F-B4EB-0FEB3EED37F2@oracle.com>
References: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d49613e1-9389-47f8-b3ca-08da65bce6f8
x-ms-traffictypediagnostic: CO1PR10MB4531:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4w9byFvj8karn7XWQMXRwHNXxpDarEZHjSylLQBRSoOEb+wH2U62tpGLubGZtLWSrsfAJKBvS1gW9fqvCOnc9yh4XeEOJkO2XlPhDl2ekpN6ps+Kpw3dkEGoyrZUpMNuCRIu1wYhkYlUgU4sR98dM39fIIk0+XWCB9bMoXVtFsoxUQrWvq1k2Ygf33Nn6ipbvx3Du6v0Z7zBwgxcAeVc1IG4ER/njLUVZQOVAssePMgxzNacbYIaOBRpPsjOsOuCh/VQ1H4PTg31QozQPJbjR8v+0XZtMQc2CXRU6pbuOHKmi/Olp02hyAXDI+O+tjKjD1LUy270/LsYOf2PBEzUFrCma1k0vp3FAHnm3+MEHW8RlMxRAXWVdrI0C2TNdu27zwfHYSdxXIMXm0uPEmJiUUj4hvNWcLCB1xmP0iPi+J44Tng4AU7tVT2lFy3uz+PNUeErg2+5kzGKDkk0k7ralmeozylV+ZMR280AeFt7RMSfQ68YNB5GIuw5ddhZ9dIsDW32vTxWyUQ1O3UMZhYd2ba372xji4cXr/bcNc8+mmFnPanT++tF/vXf6cYQD6Eq7mBcKv8RLLIgdX5/SjCQUZPjla3Y0xFnrRfUs6yl6JtZpt2k0YL9mNQyMckx7UMjoEki6V7EUeU5WN1d8VE2r8LQNkxsXpdGyadb7B8qyslI4eMP5iGQiJWswrNt7dMHHCq84sPYrqjOIyVLMDRmkiVe+2weQZoeEh/gqfE4oPz9RTRKCtlUTMZPe15GWzmCyIr1D4xFhHhqfzCHQP2w9p0xIJKtj6zqA8MsR5jK2BDfxXSeAAQhX98Z3zVk+FeTfWQ2PqvChsI6w5GII74chU6iOe+lz0Km05/hpqmai/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(346002)(396003)(376002)(8936002)(5660300002)(2906002)(6512007)(26005)(53546011)(6506007)(66946007)(64756008)(66556008)(8676002)(66476007)(66446008)(91956017)(4326008)(33656002)(76116006)(38070700005)(38100700002)(122000001)(6862004)(36756003)(186003)(316002)(86362001)(37006003)(71200400001)(6636002)(6486002)(478600001)(41300700001)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ULyfanR1+ESL7f+6s6MHgljG7jyMf9EK0LgQXrC3k0pDYUNcdAPmjR+967cq?=
 =?us-ascii?Q?kPXetPiI+DKk12weeoIBaBw1rE4osp9i6FS3rfju44sIs/VJIxSLeW4s7nPF?=
 =?us-ascii?Q?eMdD1HJRKDa9PaWLDn3pyOizmy8G3CR+eJtJO1EMAXM1liuIq6y7hRliJC6x?=
 =?us-ascii?Q?6gUefrtZfCcgM05bzyK9XwJ1Qy1Pc/a43vRNJqtClcQwUCJVuKKIBCGKPg0w?=
 =?us-ascii?Q?FkkdNtpXG3x6CkJQtFoA9BXjWFdQlCkrIGhRnoMnnFjhKzga3Dx+G/sq6aA0?=
 =?us-ascii?Q?9x2E/noyZmX5iehtSfVn67vitK8TQLO7hSjamWcFxNf/IsWv8q0lp/Q3eLiT?=
 =?us-ascii?Q?nijh6pguKugBFkg03F+av75PRqA5G9EIhxhOk3mnaYGXMmFJt2h9s9sBNA14?=
 =?us-ascii?Q?fuKuEXVChQSjunC2baVRq+BNgiE8ZMGa36UJ3J3pFEaiYaKvoRrqq2NBeMqe?=
 =?us-ascii?Q?AsFuUvD1q/H7xyTfXv/JxVzmkctbp0Wvvuv9rhEbbuWFtFOLzQOzF3vyPALP?=
 =?us-ascii?Q?h1sbICwcBunhjGAtM4kP8Q9ZsS+PILxIdkI125P8rsMzZ05raPbEHWGhMzDx?=
 =?us-ascii?Q?ItjsFj9jydRBBm8laHzcjpxn8bC0JX/ZVuvryCmHi4b7/50XNf2gSmBpMXxZ?=
 =?us-ascii?Q?x2dpBEKzF+1Oy5o2yNhzPSbugeD/5aN0kUciOEAXoN4fqHWsUp21qmWrbvUh?=
 =?us-ascii?Q?S+Cxe0W+vWqc0yQHVgBfkLGkTLwT0mS2rLeoDREIajQxbOj7Fv0HukQ2hx3U?=
 =?us-ascii?Q?mxuONXVXHMXik4Xv9LREki4xFJP5qKD+OZ1QIO/txO6nnqGCq4bvRjNe8vV6?=
 =?us-ascii?Q?Tkk1FuBb7PEVh2cQQjo+erdNBkl+m35b2vBAnI7co1hg43IbRfObFIKHtNui?=
 =?us-ascii?Q?n+x27ugM5rRAC3QGWrylXAuiX4DOo/vnELwcLMgdKlUVUdmj5lifHQ2ldCsm?=
 =?us-ascii?Q?yCIciJoLtUqoJi47Qeo3mCt6R/NddmCrBReYtMwQLLvXEs9u84bIed4L7YyE?=
 =?us-ascii?Q?sFiOxOf7YIaG3xYEV9CjoYua7YjLbZLcoHrfKZY7RmaXSrxwqFwnGfrI8RD6?=
 =?us-ascii?Q?ShW6MeRZ0kkqfxCanAmSL1d6+BryfgVD2J5jl7BxRKQhdQ1k8hhp7cPzgSOT?=
 =?us-ascii?Q?lB+VWS0ZyOkqGp8uqRo0NxRO/mmOuLndi2J5fdgRHY1HGY+U9gyTTWIXGrWM?=
 =?us-ascii?Q?KrQl97kF+nR4u9tYO21KGDTE9zf7pksdKmy0qbi0H98BR3gLUQp7eXPcOh2I?=
 =?us-ascii?Q?kQ/l/H8bk6+AdknDuNs1ukHIlMTnU3qp7gpfd+FGIm7s29yemeE7hzje9Ykp?=
 =?us-ascii?Q?2GuBLXWPSGiaETeV6P3tyFgIcft6Sx5o1cXYSEACif0jHO//PZ1DmQggHZZ+?=
 =?us-ascii?Q?JybnQ0qXroSTsjKX+A9P4aPmzX8hkRyUoOMtUgPJr1meCq+27LW2RbyzG3Xa?=
 =?us-ascii?Q?vi23Y7LFZBcX/stbh2NEXhmHYMRybMG43HO16KeFQA4EkE3ZzGcYq+AZ+dvh?=
 =?us-ascii?Q?Xdx0D2vCUe8Hg9/RQ8JH1JVZ9q/EVRZjQ6unuh+EEINnGVrTJm6vaeJhJcJF?=
 =?us-ascii?Q?sNlOevQwuGKLBJLiYufjn6WtH05f3JH9eZSJqtF1bVTOP07zzjnffhNF6FPS?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEB535A811B7144A9DE8F837733B45B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49613e1-9389-47f8-b3ca-08da65bce6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 17:18:42.9193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yw+br96ioNqxaHxircTJTJtCHrc5N/McVtmHD6mut3J5cl7YbvTbg0vWplQoaMPtarIKLktkyqR8/kCnWDO0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=970 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140075
X-Proofpoint-GUID: SX6j1Pn0ltGyWbybbY9qNA8ftN-NqJRP
X-Proofpoint-ORIG-GUID: SX6j1Pn0ltGyWbybbY9qNA8ftN-NqJRP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2022, at 12:17 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch series enforces a limit on the number of v4 clients allowed
> in the system. With Courteous server support there are potentially a
> lots courtesy clients exist in the system that use up memory resource
> preventing them to be used by other components in the system. Also
> without a limit on the number of clients, the number of clients can
> grow to a very large number even for system with small memory configurati=
on
> eventually render the system into an unusable state.
>=20
> v2:
> . move all defines to nfsd.h
> . replace unsigned int nfs4_max_client to int
> . kick start laundromat in alloc_client when max client reached.
> . restyle compute of maxreap in nfs4_get_client_reaplist to oneline.
> . redo enforce of maxreap in nfs4_get_client_reaplist for readability
> . use bit-wise interger to compute usable memory in nfsd_init_net.
> . replace NFS4_MAX_CLIENTS_PER_4GB to NFS4_CLIENTS_PER_GB.
> . use all memory, including high mem, to compute max client.

Hello Dai, I applied these two to NFSD's for-next branch for early
adopters and other testing and review.


> ---
>=20
> Dai Ngo (2):
>      NFSD: keep track of the number of v4 clients in the system
>      NFSD: limit the number of v4 clients to 1024 per 1GB of system memor=
y
>=20
> fs/nfsd/netns.h     |  3 +++
> fs/nfsd/nfs4state.c | 28 ++++++++++++++++++++--------
> fs/nfsd/nfsctl.c    |  8 ++++++++
> fs/nfsd/nfsd.h      |  2 ++
> 4 files changed, 33 insertions(+), 8 deletions(-)
> --
> Dai Ngo
>=20

--
Chuck Lever



