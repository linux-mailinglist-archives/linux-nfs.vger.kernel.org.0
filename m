Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E56B587E33
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiHBOfk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiHBOfj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 10:35:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9064D2
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 07:35:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272EV9LP024148;
        Tue, 2 Aug 2022 14:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fBu+PoMUZp3bcko0oAxRZPN5mtXBTan/uYWJZs0m7BE=;
 b=Al4c8S2Yp/YxL3jnvvBYaQA8/NpAKb9sUic7o0F1aOXq5VKHFf+yCoeBDxzirI80mNpt
 F2SUQU9+MjArfB83gwo0XDzk8tBhEdPioYaT2xs+XAbFE8lfcUBZaeeTkE+oFLFrO7rM
 VTPgQzI6Nhi866VRN9+L8Nn3Lh6AUwge7lTGVRRv+EyfiWPMVUBirPRe03E4EOBY6KCP
 xx5/KaJ+RgaVUwPDEiGnaspLbKvyEuoqOEmP4sV+fvCILWuT/URUWN0tfBuA6Urbbys1
 8eCZjX0rIwbn0WUWJssH+adyU23x6sbS0GMjA0jeEUErrZC9flsMO2/N3CzVyqjbazqC 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmw6tf0dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 14:35:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272EXrWX007358;
        Tue, 2 Aug 2022 14:35:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu323xfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 14:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3XV1K2qbqjalzBhGWzhv73WT57H5NjO4dKyxTQnUYTHgHO1/tOdGRdjrLPLP7mE/q47lhpB+mwK8bPGIIy7klf7gzESpPysdadBEds/bd6uQ8bzo2ZrNIBZx/mocTfmv7vePP0eidWEl1kLmENCVOC0PxjlZXXYOWVX8qqi+Ntf1rkSVSST/uvDsqoKrzqEZJTb7QSsaunI1NPAQBPW51KckdB60NVLlDnFQRHgSNDicbFV/Yzy+xyWP1RwsS1symiZmuqEzpMdA4j/UrEZIc4li3KMiwMHtB6dv7lCj2EXU1ArNFIOUEfqXpXmuOr2XIed/0uc9vOpS90+aNvp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBu+PoMUZp3bcko0oAxRZPN5mtXBTan/uYWJZs0m7BE=;
 b=HAU18d7U1Z8e3/1ee3QuJtrEkGOFmB65NDGLfBwNJ2XFDHvBrpoUEYBy7OPyQMe+S4F1pL2lR15haYsK32ACRzLppTcx9TmqcoFQGnZ1LuBR5TMYXilz6XcJXa9QXiYeELfGz0r1jRhO4fcfHfjRxzGNlW3vfVtpMWSrPg7bWTTR5cgNMLUKqVHrfOse7OQssmdauTzTpZoTJMkxvYqQMxdXZfivKRrw5bO0tTrOtdKY1hHYcmExb2Li8hBdj3xScxylxFx9VDq0zCXOMSASVgKA2nENYNmmMOyI5lyA1+Yy2RKdZ578DMhU2zQWUQyPIkBdOcgvmgFGUbtMN6odiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBu+PoMUZp3bcko0oAxRZPN5mtXBTan/uYWJZs0m7BE=;
 b=TXs0o7KlD7LgWHCBoY/UoisNrUV3MZ0/E43YhFwi6CvCaMNJZjAwHxPOVmFW03fwfjD7RMhp/4Dn7WcvV9AJKkHjEgWv0HA4ir6il/17K508OzIxgThIq1veHiglMF7lNd8s0oaGZd32+D6+JHAFHERbVNyZcVoB3tpM/qyEV+s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6308.namprd10.prod.outlook.com (2603:10b6:806:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 2 Aug
 2022 14:35:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 14:35:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
Thread-Topic: [PATCH v2] NFSD: fix use-after-free on source server when doing
 inter-server copy
Thread-Index: AQHYphKND+E8pLJojUWzV0V0pTRpEa2brg+A
Date:   Tue, 2 Aug 2022 14:35:25 +0000
Message-ID: <E146112C-33EE-4143-92F7-7515638301D7@oracle.com>
References: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1659405154-21910-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0db21b07-b705-4577-8c9a-08da74943d24
x-ms-traffictypediagnostic: SN7PR10MB6308:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+VYBP8mBSOAqYdYMdtj2MWnb9CXdTBPl/b4HZXKuAddJr7XchD0I2TToLr1IsUr4jXvwUVqId7UgdvZWtB/qDHaGcvUrlzSMkA/zwhgri4fLwuuJCj9XhVRZr/cnOl5qC+GVLg/iNPh8Wcui3rS7wPy51KGBSxbjqSmKZBVejCkDWLbI2uGZEjLe1RXZe3HemB7h1veckSvHxpgaAx17F6T17A4f9/BW+psgL3HvGKxeO9nRaySZrKW1+QWGacehl5ZC4mV1cKMQ6D7ryF+qmBUuxTalgeN4LUM486C874eK2ecgbIipG57sOmE9RTMeJjkF7oKmkNGrr5E+XLLNI3sYwatkBmv2zY4clUn+hYXy6T1SZREsyMDzjDaH+4yTTpzTnmPWcF6BpQgcWCEsaNqS6l8z2jXNfvb5em2DeRMH4kyrbBp8QFs9iXWYi4T/kNLA2pzJn3ET9XDo+shMhpTMxckmoFgTqV491WfM3FOs4P5wlkOW1aeh651iZ3Afr/jsgPc56JVwgQqvX014jqQ3z6hazQbPNQd6cavV+ExupQuMDf3gfYFp1QUD5Is8PmAGLVfiDVWJ8c2H3qaYomYR1u0zugg17iIostxC5dfxlwDr0g37RI5IHtwp4mlSt3DR8lCJOeSbhHhOHsx3GqMJPc0oLmVD9MWGYaLdbAlOxcTpjsrH0zRqGBv9UsBgTtT+dCT/absDEOqzN0UlREbprMIjboRFXILU72zFS8CUE46x9Ze2TVXKPzAV1/nehiKDYZd/abPOgKiaZa3AZMsYQEcU85mYEOvPW/bLKMKgXnij9bap8Q6llGgTK0dSSRNWWThqouJjE4OPcFuFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(376002)(136003)(346002)(26005)(6512007)(41300700001)(86362001)(33656002)(53546011)(6506007)(54906003)(37006003)(6636002)(316002)(6486002)(478600001)(71200400001)(122000001)(38070700005)(2616005)(38100700002)(83380400001)(186003)(6862004)(5660300002)(2906002)(91956017)(76116006)(66946007)(66476007)(66446008)(8676002)(66556008)(8936002)(4326008)(64756008)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tRT1fsD8rtLqXjDSWCPLIxNNEjcjr6TqQem6vrplX0/D+kov1EH5aaAii6UW?=
 =?us-ascii?Q?cLrvqmiPBwSCiEZcD1kbSMQ4dzEdqCJkPzfxInW1EgcnPqtlnpixLZfRxbPm?=
 =?us-ascii?Q?tGPn+SLmIIXVEay6E/aIvmhWzwZn4Y4sxCvqUOU47DtB40gbmT3prMSjjFjK?=
 =?us-ascii?Q?HP5H4Y9CI5QXchfJxkm5XAYJUVZ+drgvJ0Ih1mLZjYbw9MHeY86JvPy2uErf?=
 =?us-ascii?Q?Ka/GiLtzhJD6kINvQdgL1zuFTObNW4x8wdTgNP3UZng9FuNhvCvO6dcTQGfK?=
 =?us-ascii?Q?QKLhfs3mF/5Fg5ePMDCvpVE8yhAF/yQT/vK84ZSkdAjTeFJFO/JrqHjHUfxY?=
 =?us-ascii?Q?jSRsv92E/AyCpPaqd8yARSmwZkLkDr9Rql/cgNweT0U3ZumH+RzrDMN2c8qX?=
 =?us-ascii?Q?Z3DzDFSLADXUrOKz8Ghzd+/+LgohRW1//J5gfs1q/zwEC8faZhtwMZdf7FBU?=
 =?us-ascii?Q?KJSvmmtHdfwfyDJxIpfPO7a3kOMAXBC/dK3Tuef80AYwGalWCPiELSuMBPUq?=
 =?us-ascii?Q?+VC/LNSGP8V1ElmIujjTcqLpm6CbErefzKaNVjONrG5/zlCH9ehR8Gc0BGLu?=
 =?us-ascii?Q?+MiMhb0HmTStUGeEaYbBWf3manPsm+8F0IrEUNBaaRoYKtEvoV5ADUBf7PGW?=
 =?us-ascii?Q?Prpb3TFW53V8I29Q5B/LAJPD56h7LwfuE/269SDQy9g9hTDKXZT3vLI2Fp0R?=
 =?us-ascii?Q?FJw5b4NOyNemhYR79zagZ+N/v8EhKFE1bbIrOFjbnTTb++/40y3wevwGbv3r?=
 =?us-ascii?Q?JouGhXi/4U/35LnH7PLbRiVGLBWY0lHsAG7moYy+K9QrAZPSnPa/YOMpqTw6?=
 =?us-ascii?Q?C22xvU7ESib+l+J9P+AShzHmJwgIaOEX1kS5iQIeOKlBrC/RFa/Icr05TJLn?=
 =?us-ascii?Q?Z4roA1gemVM52DM3/9OsPEImMOpUmRz4iLMoSQhQWPjPhKestXIyrj6jQdAu?=
 =?us-ascii?Q?OUcDgaKgCpz9QIXIUqkZ4FObtHZIs5ZIwFLGlqziyHDeKyLXTC1iER1V/GOA?=
 =?us-ascii?Q?AkRfftTcvH/AS68tmZQtGJh84cS579TYhJOZ9Hz/nFeK6eAUxPpHdlxPZpvT?=
 =?us-ascii?Q?NthHnxjHaHoX/3RmF/CYO9fZmhdWpLjLI52ggxEosK53CsxZEkn7M+JhHwSd?=
 =?us-ascii?Q?jRQypvO8D9Q3U/1Z/uGJcSK/IK/c8uFLRnWh6xXcOykWKjjZ//d5o8kt9qwd?=
 =?us-ascii?Q?u1Fs5B97h86k9VvPNVaBoHrwtzfDlawMK1S/hkevHmvP65gdev6JRS1W/rky?=
 =?us-ascii?Q?DbyoZ1xkRgryi2mvgNxwt5UVaYbtMr+JEGE8Qn8yT/ffM658VCmQIPQFQxXW?=
 =?us-ascii?Q?h9FE+Cf43R55Rv/slfj9+m4NvzN5jEpxGgptaRuzN2bctYyPkQa2VJs/EedV?=
 =?us-ascii?Q?eoCFCfu2xh5+JgyqTn/jO6azpXK+nMGU8nZjeLViMgYO8ZpTXbdyrUtqDBz1?=
 =?us-ascii?Q?menWiWfowEwjvlUzouyZt2NqcEke5rD59Cq8CPq8wnj3I0W5fT2+Cw63IEPL?=
 =?us-ascii?Q?uOhmikgrSHDQJit9Ao08OS0lU5Ag5425RGJszL0cMLmNi70ZGRBPLlSeLGqi?=
 =?us-ascii?Q?SCn1B9ZFeCUbpfcdsVwotWM5JwwfMkDslQaxW3LAXtBuvQHhs4XprZLtCTJ4?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D7D9934890EAC48946B097C712C4330@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db21b07-b705-4577-8c9a-08da74943d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 14:35:25.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deYoU9DLX2QSRYRQYJ+47XIaIE10P0ErmwEejXwXarLA7tjW1ZmC0WTrrBTC+/un48vYawWMRM3y/UeIp4ZuhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_08,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020067
X-Proofpoint-GUID: VPCg_B7xhFCm-AYhLGmx0bQCSmhMGEs6
X-Proofpoint-ORIG-GUID: VPCg_B7xhFCm-AYhLGmx0bQCSmhMGEs6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 1, 2022, at 9:52 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Use-after-free occurred when the laundromat tried to free expired
> cpntf_state entry on the s2s_cp_stateids list after inter-server
> copy completed. The sc_cp_list that the expired copy state was
> inserted on was already freed.
>=20
> When COPY completes, the Linux client normally sends LOCKU(lock_state x),
> FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
> The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
> from the s2s_cp_stateids list before freeing the lock state's stid.
>=20
> However, sometimes the CLOSE was sent before the FREE_STATEID request.
> When this happens, the nfsd4_close_open_stateid call from nfsd4_close
> frees all lock states on its st_locks list without cleaning up the copy
> state on the sc_cp_list list. When the time the FREE_STATEID arrives the
> server returns BAD_STATEID since the lock state was freed. This causes
> the use-after-free error to occur when the laundromat tries to free
> the expired cpntf_state.
>=20
> This patch adds a call to nfs4_free_cpntf_statelist in
> nfsd4_close_open_stateid to clean up the copy state before calling
> free_ol_stateid_reaplist to free the lock state's stid on the reaplist.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Applied to my private tree for testing.
I added "Cc: <stable@vger.kernel.org> # 5.6+".


> ---
> fs/nfsd/nfs4state.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..b99c545f93e4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1049,6 +1049,9 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_sta=
teid(struct nfs4_client *clp)
>=20
> static void nfs4_free_deleg(struct nfs4_stid *stid)
> {
> +	struct nfs4_ol_stateid *stp =3D openlockstateid(stid);
> +
> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
> 	kmem_cache_free(deleg_slab, stid);
> 	atomic_long_dec(&num_delegations);
> }
> @@ -1463,6 +1466,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *=
stid)
> 	release_all_access(stp);
> 	if (stp->st_stateowner)
> 		nfs4_put_stateowner(stp->st_stateowner);
> +	WARN_ON(!list_empty(&stp->st_stid.sc_cp_list));
> 	kmem_cache_free(stateid_slab, stid);
> }
>=20
> @@ -6608,6 +6612,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
> 	struct nfs4_client *clp =3D s->st_stid.sc_client;
> 	bool unhashed;
> 	LIST_HEAD(reaplist);
> +	struct nfs4_ol_stateid *stp;
>=20
> 	spin_lock(&clp->cl_lock);
> 	unhashed =3D unhash_open_stateid(s, &reaplist);
> @@ -6616,6 +6621,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
> 		if (unhashed)
> 			put_ol_stateid_locked(s, &reaplist);
> 		spin_unlock(&clp->cl_lock);
> +		list_for_each_entry(stp, &reaplist, st_locks)
> +			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
> 		free_ol_stateid_reaplist(&reaplist);
> 	} else {
> 		spin_unlock(&clp->cl_lock);
> --=20
> 2.9.5
>=20

--
Chuck Lever



