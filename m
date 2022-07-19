Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39A57A289
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiGSO7e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbiGSO7b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 10:59:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9AC4AD59
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 07:59:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JEwYnl015097;
        Tue, 19 Jul 2022 14:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3xvMYKrAVdClQrR9Hf6PZBrVIc6Cpxa9k1c6A1X4Aqc=;
 b=GNSCo/HeW5JkKtslTfX5g2RlwHjgtjdZIqUBRlpGvQW+lIZ03Q9PjNexlE7PxFuB2Ms5
 4gkr1eNQWqB4Ju2SVg9qNVgUiPETI6RtLGNMJXPUNldPfW+ZszziK3KwpB59Ap7DYmJI
 HUeebaKtsobs4widFxFtLt90fzuWBx6teB6x6ODI6UAJGDq7AcoB9qfJpGgSxDt1qI1U
 0k2HBaQK31ytz6UJrq4MnKIZ2lEVslhxC6CqUzGJCStADljJs3RTnHfVNKVvtLG2I3rY
 ddgdeu1VyYKVh5/qq91aDyW5+INQClUFJY9dIStUruEHyb5es0MAlvAIr2ewF1TjhSzd tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42epqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 14:59:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JESOZU009848;
        Tue, 19 Jul 2022 14:59:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ggjmbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 14:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioho6L18mUiH5KoDkryz+kTAOQxxZMZ7CK5xSGVitfAaNzGC2DcVp00al9ZRNZ7wnjvnoIgJ6Mugo1BWenqCvDOLvIz5uYPjj5fugGkDL2EnroTmb5EeQuoF7jOvYcL16q3uWna/VWLJ3R9zriIWoVvGTg/NJoFQTwGttJYoD3Hrl0Clz9df5ADgjg+My349GQ8X3ge9xve2luS9Wy2KFq2bK0aUiWiTKNbNMhMG3/cKyNKCVQEZ9dhDVI4XT1V4JDs8jzGsRiqJWqfdSL//xYqL4qlGWsISVDEORCArbA19nOqn7ZwcrFLux7OXN2vuIa1sIcdfEdKmKWlwA79wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xvMYKrAVdClQrR9Hf6PZBrVIc6Cpxa9k1c6A1X4Aqc=;
 b=Zd/nWQWINnMkCcneXTT+anhzVPMKWlHSeKjr8UIdj9dhTpN+2OoxqeuATnIpzkPa9mu0x15MpvBEUlpSA7qiJE1U5kDw4E3BmPKNpEHM4TIlBIRstCLugQVcb32+h7ztWs0E4fxeUKjkkSSqpFFMrYNFv4Us197579q1dhCcflzk8WKx9fXSf5dz98KQM1lYHMDEwpDBOPFHhzERv6je6LcVIRYpyo5wkO6yYVmhIYqQri4g5z0hnIPI/BonV1JNk50Ck6lDFN+LU8wKBYX8Z8f1/9E5TKPmegUStYUKmmOAVouZzU5npBkbUQzmMvRNu+Qgm5+cHfAlUfn44yaRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xvMYKrAVdClQrR9Hf6PZBrVIc6Cpxa9k1c6A1X4Aqc=;
 b=aPAvxos7hisX35cIR1whMDk12u27VfOelvtFjIijJqfTeb3tlsCukpNnrIuKZzkXwGQ9WHEnrVCDT7HnZ/iQY+KIVXCqJqnYXAe9QY+6sqjERgyfWaBJt9vEa3naZ2QrPh2beGyGNXqZ27otSTNqpM+YjxqEkw60txYl80o+lww=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3822.namprd10.prod.outlook.com (2603:10b6:208:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 14:59:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 14:59:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Remove CONFIG_SUNRPC_GSS_MODULE
Thread-Topic: [PATCH] NFSD: Remove CONFIG_SUNRPC_GSS_MODULE
Thread-Index: AQHYmq7FTbvVJcL0IE6jwSQssKBM4q2FEDuAgAChFgCAABP9AIAABZYA
Date:   Tue, 19 Jul 2022 14:59:22 +0000
Message-ID: <5DCB9FF7-D56F-4A5B-B36D-9D28550B643E@oracle.com>
References: <165815281251.8395.9611588593452344848.stgit@klimt.1015granger.net>
 <YtYqNZCazm64S/Di@infradead.org>
 <4936C3D6-AE4B-4F7F-89D1-17CBF38A5CD5@oracle.com>
 <YtbCGoJ7+ynzqqHX@infradead.org>
In-Reply-To: <YtbCGoJ7+ynzqqHX@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 036949bb-db54-4e09-e2db-08da6997441d
x-ms-traffictypediagnostic: MN2PR10MB3822:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9b71kq7nrtc124ox66HSb4vnI+x2EpwKhsce+L8+LsClKrUw3oJnZ94fin34cTrw9pbll/IPAmDlwAmm5/xWYJ7022m4mXvrjmPqMU28qJr0ESMwkz5J/EWbJEiWOT5YubQh4W1LZsbO+wm9uja/xlkutIcUkR7L7FdfoHTRWowRySkmPgGOPj8OfMxIjrheSBoDWZayTApK/sbZUuKy0lE3cq5tqCoAD/RCZs7qx99ET5oawkY7aMltNLwTLDBqJ1yt2VRlqN19hhRPStvy8pUcvVtQNEpvGOmw+EecoKd0tRod4nEBqTzFa17HjLTaxLRB+nJugjHQca4r6j9OmfxAT2WeVtB4XqRiBu/28iHienOl1yI2uedrNrlP8SS9hLk7STse0DdGLoNNICXyJZxY0uiq2hZB1/xkApx7/ZFgPhxtAvCmth5j1z9qFhLy0ssegCL+Oq6vEpXe/g6u4vqeJS2nMPcICGH2tCykViOyydlbIoczdNHqKA9mgUFWktetN4B4cGRe1Wrc2tBLuqSCTQpHOU8pFIbmMYRg2Bk50cPYxVFACHLMkUHzlmqw3GjwH8p7UJHUd0J2SdGp6QqTwlVl41Le9bb1rQ7xr/r7KyKmiVTbwCoezHzB8M9jS/busrsMaXiq9CivHIcmYpm79CTnM1qb4txPGaMsFT9TF6ClGsqbMTC9i2094C8f17ZqCDyyhpK5B0WpzgCi/S5cp3ZG+uS0fT3foYwbCru+XNQopg1DW4rmXKbK5F0J432mc4rnosNEKRPTmuUAtpIiE3+lvW6D22xKXDtfmA5A12N0bvyuFITmJzroHD703ybS/zMFStQxBvdneXkJVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(39860400002)(136003)(366004)(53546011)(66446008)(91956017)(8676002)(64756008)(4326008)(66476007)(66946007)(86362001)(38100700002)(186003)(76116006)(5660300002)(66556008)(2616005)(8936002)(478600001)(6486002)(41300700001)(6916009)(122000001)(316002)(6512007)(71200400001)(36756003)(26005)(2906002)(38070700005)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eBKcOcym+NZhgkrj3Qmx/4puw7As7fEiMDMWXWx4RTMNCBr9t49/0vhUbyJz?=
 =?us-ascii?Q?RwHxiMIV7HuT073VC8ih+rN4H4C6ARxJ2MfOa5sYDHRDsI0SP8jYzdEQcjIv?=
 =?us-ascii?Q?bOqSbK1MIR0Us+RvYZuwAmNk88/P0VuxAs3W+JE5OKHnXJpWE+GzGJ7h5iL/?=
 =?us-ascii?Q?egDHadLLbVzn+hWfuxkoUkScaCOGInUyx9ibmvNyr7Tb9nVa+wJzZzNDKlQW?=
 =?us-ascii?Q?oUOVk1tkk9YuVMKUw3PCTasPNpllu03EWIIggbNm0DykmkO1ayiBIRGt92GS?=
 =?us-ascii?Q?hAhVi/T5cKFEGcfrGOWybOOzhuOFvZqtl8keoIl/cFIcYC/9jsPiLSsGeO/L?=
 =?us-ascii?Q?57P6R3d4f83Uv7BSYlgy+7nU7ZQQ9PF/E/P1Rnv2aocQIyv6H43gZ8lCjWt+?=
 =?us-ascii?Q?Y6ppIigAFQvHiyY8V2oj+jA92MyzaiovDAxi/2VUQEjIZgyTExO1piXejIwi?=
 =?us-ascii?Q?vc0wCGUSaZcnOisZ28vtWqNjnvi44w/5Ol6vhGOQvyTxmphKl9wyKZM6h+YS?=
 =?us-ascii?Q?7p5lYKBF8+SCiuiQoDYLTMe63N9WQOewq8WBqZdCM7771M4NBqSZnv98HL99?=
 =?us-ascii?Q?cQyM8MBa+zc7mfNIQridH/8RHDW9/B7due2aAcDqj5MQ/DmpXjenLAr6sioT?=
 =?us-ascii?Q?eCEEoicVKON9votyRaFHsFWc3i9b8P9tINtKV4jZ00AlPi4jC1RlOgXZd3Ds?=
 =?us-ascii?Q?owLBLN63SJiD8CC+LyjhOQzvR4ULSWHPhrAnxwUx5s+54HxzlAlw8eWEG7rH?=
 =?us-ascii?Q?9RECmpnOhqdof/Be3dAm8pAL2LfxbseE5eBy5roLH4Czil1uK9kjZA7ZVjlX?=
 =?us-ascii?Q?uZpg56LoiL94tQlMna3tRnDjChv2UN7Vf4X9MmaNmJXXd50Xrt/jh+GQcNQT?=
 =?us-ascii?Q?x6WD5aaV38wZbIzklnztbQCIOy2oQm0cMkRTRIdLIBx+OMbOAZDkdP9fUVJY?=
 =?us-ascii?Q?DXp2L6XgFBtQU/nk97K5Fb6jiptIrztmFf3eSAeWcWTIPT3rydD1mO8BgnbV?=
 =?us-ascii?Q?befqzG1zIa3RBrztSWi4p7xKdKi7PS0CTEJR4RnN2kqUij/Eff+ppjgbUyWu?=
 =?us-ascii?Q?V6DqeyL4CMmMOv6qEp6tjfqa4z+BM0zv7ACTg4lVUwgPtxn/K/Mej530N00Z?=
 =?us-ascii?Q?t+opRcSmEo9WqQYYI+5tPgvI6f+JygnYWgUB6EqGAq0LnyqzrqRMNuLBG/6y?=
 =?us-ascii?Q?/FHEOcIoPW9O/QmTJFgK9OHrBYwsOoxr+z+CTnCBmEEQ+OQeAIx2C3tNMsdd?=
 =?us-ascii?Q?6VG4VV35SITbB1k42WOeguXWexBadIG3Hs1yHwLnfkz8sGtLcwV4gCphDVC8?=
 =?us-ascii?Q?InC2COXaWhk4/4hhCbT3PSMv1baAjX3pe4iFWUXFQxFnU3ZCUvthnow2wBQ/?=
 =?us-ascii?Q?T/t2L/WT1Lf/4AiBfJNK8ykH7Xg4GqQ8RS/m9tZs6i7PddpKgg9Y3dWmsmJj?=
 =?us-ascii?Q?sZTZWMBOAx6KTbvgh5inGMgbW8T4pl/5sVKri8ozxDspgrg1LPyxZdLTh/Ic?=
 =?us-ascii?Q?4u9XqUJh64tYAgj07QXdexoJ/rabfhiHzzutJm4VAyjUuT1kR6/9qMeImXLn?=
 =?us-ascii?Q?hoPOsOKXLhADXgS1MlYwsf/VRs1EmvNYgtsHfHPgFEnEj2EIk6nZkDzOMkLZ?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB5643652369B343A2991D425D78830A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036949bb-db54-4e09-e2db-08da6997441d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 14:59:22.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBT4+i26Znqytas6SOd2IeuP7yOzdn72yTnMA0ZnucshbvSWSP8vbc6eNuRF/33KPko4ZcvTnDj+Os2A7M7Bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_03,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190062
X-Proofpoint-ORIG-GUID: ZNuDEEGP7v8LzYtV5irhOXrDODXmqFo-
X-Proofpoint-GUID: ZNuDEEGP7v8LzYtV5irhOXrDODXmqFo-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2022, at 10:39 AM, Christoph Hellwig <hch@infradead.org> wrote=
:
>=20
> On Tue, Jul 19, 2022 at 01:27:51PM +0000, Chuck Lever III wrote:
>>> CONFIG_SUNRPC_GSS_MODULE is set if SUNRPC_GSS is built as a module.
>>> CONFIG_*_MODULE is Kconfig-generated magic.
>>=20
>> I can drop this patch, but I still have questions (and I know you are
>> just the messenger, you might not know the answers).
>>=20
>> Where is this convention documented?
>>=20
>> When would CONFIG_SUNRPC_GSS_MODULE be defined but CONFIG_SUNRPC_GSS isn=
't?
>=20
> If .config has CONFIG_SUNRPC_GSS=3Dy, CONFIG_SUNRPC_GSS is set, but
> CONFIG_SUNRPC_GSS_MODULE is not.
>=20
> If .config has CONFIG_SUNRPC_GSS=3Dm, CONFIG_SUNRPC_GSS_MODULE is set,
> but CONFIG_SUNRPC_GSS is not.
>=20
> As Anna said these days we have the IS_ENABLED helper to mostly hide
> this.

IS_ENABLED was added by 2a11c8ea20bf ("kconfig: Introduce IS_ENABLED(),
IS_BUILTIN() and IS_MODULE()"), in July of 2011.

The commit that added the explicit check for CONFIG_SUNRPC_GSS_MODULE
is b084f598df36 ("nfsd: fix dependency of nfsd on auth_rpcgss"),
written in May of 2011.

So it's likely this is indeed just an open-coded IS_ENABLED().


--
Chuck Lever



