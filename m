Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E437586E8A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiHAQ31 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiHAQ30 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 12:29:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46DE2AE31
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 09:29:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271G98D3021260;
        Mon, 1 Aug 2022 16:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uFRbGRWgAJz3Eh+88sZoskz65aR8sDTwf01KrKuqH9M=;
 b=Enz2e4n5AL793kFmyHfiW+puALbhDi7Of2WKEyRyoS4VSxCUU/k/cOfFWD+qzMXqk2XQ
 wUMXp1H6ZQDqur/W/vLHIedG900bolBEfH2CtQBMpNzzyKYcAtiadm2ruinAnZqGOWBz
 jgx+hEMxtxnxwfMNqZO8c6zlTusl9yEDc6Bv2Vcb0iYcrd85hdUQtx9YDiVqLPLvZQdA
 Z/cG0qDhW7RBZwdTNYLeK2oSIcJNTcR2iftHQy1+dImWWdeaRwPPMDVc1Wn7St6BiAY0
 iYqQum4XgrEafTVWGsRmr5sVcue3FREioZaUNSfRHyjaYQxV7RWORTiCpbsdV5YnpD7f vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu80v80g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 16:29:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271ETpOn007358;
        Mon, 1 Aug 2022 16:29:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu317d92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 16:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyUgShRAcFdmxJE8nvHOYC46TDSAqCNe1UzY3Z5LBqdq8KjlwzkoRjadCiRDdo4cdLXk/6qGg50y/k1bqPBC3CZ0z9w4jh/ptmnIYn4XlntU3+LbhNh7HEsCiD+s3NIJ1AGxD7G4bITKHJqS4JTPbrMYQ3eHK0bnSXiIdEZhwVxJvLH3ZXoH6K1MF7s5HZrR4Yuo4mK0maCEeuAEjTNpPgAitF4r/it6XHWeu5uklDQdhh1eWR77WBDcuFhugl8St7+pb/961NZeyMpF37OFTF7aXEhOTK1dZiMCbz/Eq6WYj4W7Sci0u92ginI6I8xFosapaiq3Th9EJR+4JgxpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFRbGRWgAJz3Eh+88sZoskz65aR8sDTwf01KrKuqH9M=;
 b=QUm4Oj+cZr8cahnsrpHrSDouR5ScSUO/dRZryWmHWC4i6THpvV31edODpj4k2S8/JkMy/qA7shsNcpVlWuXtvgbUaE/pUHnL/AkuBIplIyXJBgd8biV4tOAxS4fr59TTrZpK2eq8N/ZdGrnP9U5HZzLycyKXmqf+fLVRFKnuT+rJumJYh/ghj4VpMA6cHEeZRSpalkE4o98xtWXnMMhpX0QcAwcq3/w5x6Y0Jvlx2cGa12IuMAZLN30+U5xxWP20gj9KgOSkJBgw8eXa/A6HoOwT5c6N+wVzIXgrAtuU/k0/9fQEVhEfSi3nuyfP7qIc+8lPmNqW5DIpC0IMCecs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFRbGRWgAJz3Eh+88sZoskz65aR8sDTwf01KrKuqH9M=;
 b=JTb9/xD7FyRN4lDYK9BOBJa0Us7uNh1+l9gkEgyyeEJXVVA25L5/kTzqQ+qJtCrjTu1mU4YsJb50AKXrfWDanx2QT9zYSzvhOUkKBcP+bJkFppgTzq4ElIahCOTPian9+Xjdm8UGG7WAjCuKuETZPzKrvNcRiMhrSeqKZTB9fjw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 16:29:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 16:29:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
Thread-Topic: [PATCH] NFSD: fix use-after-free on source server when doing
 inter-server copy
Thread-Index: AQHYpRrq3VSBDvRXmU2iM7U3Z61RMa2aPX+A
Date:   Mon, 1 Aug 2022 16:29:21 +0000
Message-ID: <37585D43-78F3-4132-8ADF-D11BD11DDCD4@oracle.com>
References: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4af85be-3ce0-403b-8785-08da73dafd6c
x-ms-traffictypediagnostic: BLAPR10MB5009:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohlpQD2Sm1OwhGtyAK+7ilSf5qx11c/EkHbW7/20z0lyWJ2BjyUzi3ttfyetxjwx9dka47ghjrujRly3sdn24XN84z0N8Snn/QMN2kuN8UKWMbkAV8k28tPW7hQfcHJG3AUDFFySvXamesm8g6GnkvzHxqpk7TzaXTQidSw8PZ6R2eRrJE7+ADqgWjs2F2nam81tEdG6uQod1+OVcRpTcCCYMBzqp6oidwFDCKZU57yAWsFd6auL882uX+HPmEO+kzXFDKYFr9TlvomtprbnfTcik9/LsCn/7OSVtXoQ85lH0Hh1ElLLdWJXFeGgPYtkNnbHiDBSkOV60EI6Mk2Dqk4V6v6iNBJBAH5JiGcplUqnjgiVriEVj+7Cctwb8JMq+l23Lks4/1mHE/O6JyT/kl/6a4GwYXXm2fS+Q382RraJ86VhbEaXmJHdYL/SgGy1vpZOiRlycORvOCzOa1m9bXv4qF8vR5YGqgAATPYTEe41Hl/yPCS8XvveunkCewLwLbVUkQe3UxRpVoJjEMrDV0RWOaY36ofFN/1NT7B9LhA4tQRL13LiEl43hSmHheoK8mVFl2UynaJfxjN1jdilCzUvOVjkoKaUTAGHkwoMxtwu/0+4I1x1IHa/A0jOsL1bJhh9HJ9FrZHhtXxqHkzHaX0aSvQ8+TjMYure6PbkJTJzGOnYCbD3hD23SNapwipGSKpgr7UYqWQ2NQm9qyRLKZ3gO1csEJ9pt8y5Fddk0mTP7TeZ4hF0cI4OzAg5EYCbQuwvOphrDq77DISy5y8wUUL28jJlDUB6tpqaVjtjYKtqBwWNP1lMv2f2GfupB7iL+Y+xgv+UXsiByVzs3+gUJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(366004)(376002)(346002)(71200400001)(6486002)(478600001)(41300700001)(2906002)(36756003)(33656002)(86362001)(91956017)(76116006)(66446008)(66556008)(64756008)(66476007)(37006003)(6636002)(66946007)(54906003)(316002)(38100700002)(186003)(2616005)(38070700005)(53546011)(6506007)(6512007)(83380400001)(5660300002)(6862004)(8936002)(8676002)(4326008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K0k0bwA9zA1z04K0pUehrLiE7jHDm2tJrqxRqNERgYpeXtitTwhTFejj/YAV?=
 =?us-ascii?Q?s43XvJSWgoP3DdOeWw+khpAP0uDDPCt7FZPkU8gJJ7i5r4MlGCM224su/PNP?=
 =?us-ascii?Q?+M3vDxWqXxrV+9dhNjGX+Wk48lq1aoC7uOgV7Org77LY1K5qEgngrgeO6S91?=
 =?us-ascii?Q?4ihMDvCfNf5axtqkAKdWYWiBbJsiFJTJqnnFO5+U1c7hjFVy91Hqb95HqHNw?=
 =?us-ascii?Q?IcQ67jIhRG0hLYn1Has92KLD6fPfrEruy0+QQcLTLyjSjW+pp7Kxjic45kNE?=
 =?us-ascii?Q?x/qG3dsE6EZq1DKYRF/FwWlPObRCOG0ZxOXA7f02gATrYo4Kc91ugxXyXeJT?=
 =?us-ascii?Q?IZRu7l1MS1yvNF5k5MUEEVKerjHpZWoSS8/B4eu/Mi7Y7nY4Mq2PSlGSTOPH?=
 =?us-ascii?Q?OKiuqIPSRAd9OjA3gliqAIYhyfn5GCqCNjn5Ix3KKmTEHGjidwKZhW1eyBWZ?=
 =?us-ascii?Q?ME9ToDQHL58g3g9VDaua7saWj0X5ZFoph2nlBGhVGLyhzR5IfZNVEsOxlyqF?=
 =?us-ascii?Q?vkRHYiUxDO5P5IvpvN5FHJdoUJAXkujKbiZhyixDYymflZthLO10SZYZRl/I?=
 =?us-ascii?Q?PL+a+aW8tDIokM4MzaDSyKjhe8eYzXUeKtRBd/bhBQ+E2XYiP8CNjdsiur06?=
 =?us-ascii?Q?T7McDF71kT6zYfa6Elu5h0K3ydmT1cSGPEsxVzM8+O4v1bPdXbPi5xT3Se5p?=
 =?us-ascii?Q?pcxpbLp5xixfV2yIv+HVlkMy6FyoNLqV+DQngeAFA101RLkR4zhlZYQtTdC4?=
 =?us-ascii?Q?iQ1FLXiWXpC6MY+LwTGwBxD/DZ2wbrZTZzwH8IRRyFJt/ikvmfJ0bLRlQHC3?=
 =?us-ascii?Q?geiloOITT5SjgQGOcemmL9zY1m3PxwIhJmKXEwKugsY4I906gEdKieFCGurl?=
 =?us-ascii?Q?pHz20Vykc1MxdQPDyKZhlM+CaOC1dG/9GucJLc/3ATkh/hk7GYFAyBv33GSv?=
 =?us-ascii?Q?4SkkV+ovfi8sInA9cZIzULZ34/wvNZbrLStJnQe2kuHFkf/gDr4AjrSg9K3s?=
 =?us-ascii?Q?NuYJ/OAi/mgTNMnxvmbNUk3F8F+PXm09SXOI5FD7+EbN7b9uM563FInqHoSU?=
 =?us-ascii?Q?PfxRVUGQpueKQC9NbeISQHsguRVv5isTk98St6lv6tQBUT5QH4O5K9Qur28w?=
 =?us-ascii?Q?amgRfHUbg2pIJC45tppv6bgZGgeHAHcg5Ev7EspXBmyq1KVOV+FB/xy665BO?=
 =?us-ascii?Q?aR4teZTR1Urb37t8hySxbrDKTcWK3sgkJrpw1u9MtMmOhKInsXQpdz9Lyhdr?=
 =?us-ascii?Q?WDaeDI29Zl4EGEjztgg18gpc1Ck4HUNstxwutl6VH0eFc22p7XJ1n2tTRbuQ?=
 =?us-ascii?Q?BE2CIl05uW/aOs25Qlmb4zfhDur0QcdgX9V9VCNykGHzVkvIAe6W+9FCL6+a?=
 =?us-ascii?Q?Umg7VUNwYmcFAZZ5MGpMqPUDUXz6V9+p6iC0v02oC0wFTOb2YcOmwt2mTM98?=
 =?us-ascii?Q?5MhFBbiQvkrwI+t8igIKPDFSeg9rOzPP3FH3U5FyvioDpSCn/AXyeO1i2Mh6?=
 =?us-ascii?Q?yAzUjbGRaf5Ox9OZtwCP5soSyNCXgz1XYsEfnfLYT7keg/5+i1RsFOqQ2fM2?=
 =?us-ascii?Q?pkbPeNsVFcg9eTZyw0mUTlbzoP7tFgE2AS7RAseTjZttRMGaxeXHcXYU2sCI?=
 =?us-ascii?Q?DXe0h7QnEupd4TgMULE05PaZwmEn7RIiIBhghRBCrhZTTy+qsqmveXtGivA4?=
 =?us-ascii?Q?O9g9hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <298630517F60E541A351A014F6B446D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4af85be-3ce0-403b-8785-08da73dafd6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 16:29:21.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShA+Fa3vw7U2HFD8wpIcluIYTcbgtOoYKgaEtczxJ7qV8oz0+jlVMt2DvtoHN6hO6VqxPiH7h5otgNZPOKQZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010084
X-Proofpoint-ORIG-GUID: 0Nbnt7MINkRBnmRuuIJ2PmLJI8cysbRx
X-Proofpoint-GUID: 0Nbnt7MINkRBnmRuuIJ2PmLJI8cysbRx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 31, 2022, at 4:19 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
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

I'm interested in Olga's comments as well, so I'm going to
wait a bit before applying this one.

Also, did you figure out where this crash started to occur?
I'd like to have a precise sense of whether this should be
backported.


> ---
> fs/nfsd/nfs4state.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9409a0dc1b76..749f51dff5c7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
_stateid *s)
> 	struct nfs4_client *clp =3D s->st_stid.sc_client;
> 	bool unhashed;
> 	LIST_HEAD(reaplist);
> +	struct nfs4_ol_stateid *stp;
>=20
> 	spin_lock(&clp->cl_lock);
> 	unhashed =3D unhash_open_stateid(s, &reaplist);
> @@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol=
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



