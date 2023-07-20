Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06275B23D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGTPQo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjGTPQj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 11:16:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48922270F;
        Thu, 20 Jul 2023 08:16:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFExBY023524;
        Thu, 20 Jul 2023 15:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8xh3Z90+sS2H3Dctc8BkRbcEWRTxXKlkgmzw2oOxOg4=;
 b=St0dgjyKwd6X6JtyJJ3eHkAy4aVh/qktPYkCZMDfTbQF16tIP4YsCERR+TsobvqnX1mM
 uj4193k85OKFgU+3heTbrOj6FOGeOIv75YzdcKYDh1ISjyNv6tMcC55fdNSQxrczSKo8
 W+/W8VzJKo25W1PjLn7NxIf4l7sXvzwZ9F+1Tl0ROYhXxddQnIUZrvm75S3IdkhhvXqd
 FJZdfP3pWdQd2admII2VEShSdRB5dijGQ2Nro4srJAAoAoYa7E4preArbB7K5Ugp1coT
 glmHnqWInOebW8nXO0YMhEPHHHXsj7Cg/smA1xWL+ApPDgOtaULN+SN7jb9ptWzkAjXy +Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run7721y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 15:15:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KEFHw7017453;
        Thu, 20 Jul 2023 15:15:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8s70d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 15:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl7XLoU0vZr66/o6xx/IXAuegOOpfXVBCuxgNt0dNyyASCqaGA9f5ERWKhNZnv0m6tsqMvDtco7DUlBrjODPRLxY921Ah+qaSHk9usd8St9WPcMIDW5khjxtM4K4w8gZwHTEG9B4Kv02KWiDOyvK3YHbWOeVv0TVdGaB5rSSLqZ9e3AxBK+PuqwdvXP55G1phxcQnou/vu8Ryi2h3p5mPdoOEQ1rEVmveVm3Xp80ZvVTQi9cVLLAxPs9sbk6LyU9S59+a+MUEbAdV8Aw10KFaug4kB2qYcFgV7Ixf/ZL0O7Ef97Lr9uZ5CD7hSixEInbEvKKjggGuEv93LmFOVbRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xh3Z90+sS2H3Dctc8BkRbcEWRTxXKlkgmzw2oOxOg4=;
 b=NQKRDm7sTziVS4cLQrMZ7LSzwDdcxpIhi07NDYSyz8kSPjvpDJDHW9VvT/oHywP7+DwrWipAQ3/cGs2GSqHFf/MuFh1EowBE+vtFAoBK4AkBFBKeWlYiDxLAGufF5+qtu4181M3aYMavaS/nVttD4QLKicHwrGAFxaOaoilRNQSidIVSAI538FYxvVxb+zrSDX7p/f3emEv/gScN23V3t59SFSL58EwEtsymmvGcksZdWqOarV09sMpNQ9Xzazh/PaFIcycHjgsEtCzL5wRMVlA4BhvpWmjXKAo0oTT5KVcS/m/TnrpgV2G9zOqytz8eTarft1ngMWM9MSbMi4/c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xh3Z90+sS2H3Dctc8BkRbcEWRTxXKlkgmzw2oOxOg4=;
 b=FuCGbS0kpT0i4aKPlWgl7CK0hxr5sI3NURWCFwO6RTC8SuSnNCKLLolcaTIXqANwqyRSxTzvzaMl3g6tht67/V6iPQyjClPAgV416K9K2BJopKc2yDbouRuIEjyrQk8hL5Con9vIJxUiCaXQw/MxgcnBYeQOTLzXbgc4bCmFRO0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL3PR10MB6115.namprd10.prod.outlook.com (2603:10b6:208:3ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 15:15:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 15:15:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Subject: Re: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
Thread-Topic: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
Thread-Index: AQHZuxrUUcSB+OrawEaFlgaCCuixU6/Cw9WA
Date:   Thu, 20 Jul 2023 15:15:41 +0000
Message-ID: <4B067A0F-93E3-435A-A32B-B17BC07D4606@oracle.com>
References: <20230720-bz2223560-v1-1-edb4900043b8@kernel.org>
In-Reply-To: <20230720-bz2223560-v1-1-edb4900043b8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BL3PR10MB6115:EE_
x-ms-office365-filtering-correlation-id: d2dd3dc9-a313-4385-869f-08db89342e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXSApoOfz5820y4SIG2LgNtT5XbhnUr8x/VKBsxX2B/DHsKkGdmKF2MxJrgfe7QtCvVHviNpGW7JgRDKYS1K5I5kmzn9V/aBMuc1SL6jllDacwb0Mwk97FmesQqm2kzlvrGWdbru7vUbf51QXncXIF32PHfQAthLPLT1uJ1gcylUa6bM6uFzPDJPGxYZY/0JDy7OeMNpANGpq6bR52qBH4R6nDChxsGFOVJwWNr5WBilfl21YBxVKwE1gfUJKIFGZyJx4IGaFEVnM1S88i8+UlzVIDuUAiIZLaHN7RddzI+r5FjdCqFK7RCXBjd+mfvvxa7tYUp2PwacbKSPMCeyHr+1/qhoJZXl37O9uElb+IodDAzG/DBnEnEWqv3Nqa3NuqdrmZIVRVt+x4Z6lN3q3w+izDucUGBIUwDxYU0PdkQKEboP3l9m6QGcpyt/t8QrmfOFELlD3PgMWMITkQGB0Xbe3aNYoEsb0XYyIR23FWMZhfJgkhaUFSxJ4B33EwtapF22Mf6wnA1kZb7cv5vdv8X5+AZHzYbj0P9XBWyQaBlDMLVLq1qZMR/inatBmmYVUXOgHoK/tE45GYN+gvDN3cviaRJYL7LKLO857mDel+TKJR/6r0vaegUYREMUXqbToTTLPhrEfXBXCAd9i2fEOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(6916009)(122000001)(54906003)(8936002)(91956017)(6486002)(2616005)(8676002)(71200400001)(478600001)(5660300002)(41300700001)(66446008)(66476007)(38100700002)(66946007)(66556008)(64756008)(316002)(76116006)(53546011)(6506007)(186003)(6512007)(966005)(83380400001)(26005)(86362001)(36756003)(2906002)(38070700005)(33656002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a1p36qkS5JuocqRTyhRu1DObEB54HN2S9SqW/Y0w2uietGbeO3djDjg8DyBn?=
 =?us-ascii?Q?eqdKbMVZH3TVKA2hvYwllq4u2A9KuRDyUHWC9RB+udOrwyxl3IzOQepSAvzB?=
 =?us-ascii?Q?HQq44bXgcng7oc7OVxRh3tyCVR0FIwrhDrkxpro6b2hrelZDL5ADbYHRGPST?=
 =?us-ascii?Q?5eCjxyVnwpYaFfIg/mo0F5yH5H5M7l5AXAxRyih0G+urtc1+lD+AaKIk1qdk?=
 =?us-ascii?Q?+dPN2Lt5HkXgEZwljBR2s3EgP5sPFaBD/u16gpi2euyH/pI1mGaTWrHUklL/?=
 =?us-ascii?Q?ykEq7IM/m3IUr8KUaBjKXoNOAW9AaJY0qS8eFYpaC/Y9ltmr8//4iFdnYEPR?=
 =?us-ascii?Q?3T+txPXecPVJpQWDjqlmObKnlWXQR0riAOYl17OaDu9X6vN1trTBcTgVnPRa?=
 =?us-ascii?Q?a0MZZLPuNM1dv43Mr7en8FzXQs9BDPyt1xGp2zj29q8vrA711ybEI9uCs+Ks?=
 =?us-ascii?Q?3iJYDNUtngFJG57O5x4GoKtIPz0w2WqXC9mIIlAyd2sLNbiFq744kvrK/mDe?=
 =?us-ascii?Q?Wcv12XDnRTD2AyesRYihAgiIfAdaXP2c2X2YTuZdHVobkkqHC4qr4aaSTJMO?=
 =?us-ascii?Q?HakUR4X6ABZKvi6EjcIMVCE1AnGre+UmfAyo+lXLFzjYrYQmHv9dZQr8HlW5?=
 =?us-ascii?Q?O+/kQ1ChjZgxt/FACBM+BN45HbHn7rCjmLXjKQ2+SdOIx4OQB/yDghqn37M8?=
 =?us-ascii?Q?OUB5Fk4TFQ2TqiEcDeUHzg2UvFMY7WVBv+3x/unRDp7PIMAuTOjaxt9mFaTL?=
 =?us-ascii?Q?f5CfPZT0VbAEaRIFRT/LW0bjAFrjVtVGNzU++xR0/5XW7LabSJJKxY2NFYMQ?=
 =?us-ascii?Q?8vredIeKjUq26Gzmb3rKAGnAp9Iv7SUmTSTpEhq7suN6UTtz0CK0nknmqXQv?=
 =?us-ascii?Q?UhN2X3sp4qYZ09hk4HN7phnw8VTnRobPVvzmqf4XWeZU2P4SqIj/MCXV9Ju6?=
 =?us-ascii?Q?fmjazcqbzNFLbnQTwfsLF6NhZeJrj7gcyFI9SJu8af+2p3sRXMt37miZ22NI?=
 =?us-ascii?Q?1e4mB9C08cb8bu++xzAngWVkWVOhp9tKg3y0n35oM2BQlGKKdIaAgxz0Lnvv?=
 =?us-ascii?Q?WG+Ir9nkmOuMlLDziF+Mr0a/jWBToALUq3r9AYvOGfrOpOHc+O4+O3lt9X6d?=
 =?us-ascii?Q?BNAfdV4+DpuoBFCXcwn8OmxxskKBCUIrSMcqEH9LmQx+EMlrODn3E1BjIbcS?=
 =?us-ascii?Q?v5Xv+kGDk+83UDY5KxRf78dBex/Kc5HsU9MJt1lguBxV6YfVXO+oNBZZ6MhD?=
 =?us-ascii?Q?ektO1xHzVsTWp/UwHfhP0te1WLtNU7+UThDqsERsx6RNXT1SpzCWydk83aUv?=
 =?us-ascii?Q?3cXbVXjcNVPfgsfBhsRzl16DCNhxSRgePdRIqRy//bphmxVJK65pybf8perM?=
 =?us-ascii?Q?dFG6QNv5ZrVXZQOmDiQqOuAP0toMgv9GVeTA1rMZ9w0jSq0R+nIMmC5hwEwh?=
 =?us-ascii?Q?IWQiaCHNCCnWHZMQigQadbc8BhH03RYKr2iJlwmoKUq81OBaxp4Z/1ghDE1l?=
 =?us-ascii?Q?95J9v7rMCIDhOSC8RX7Thwh9tPPGRPmRvsBm7+7XRG/k5IkPlUICGx+LlRT6?=
 =?us-ascii?Q?OTUBt8aQaKBB1eIrFI4cIcRGN9zFzGT/6EG7kGJl+F1uSPle42ByLcWaCXfm?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF0EDD30CFD4CE4BA9657E20D2BD5927@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LWGl3SSz7MuvGx3NVGZIoSrqObxeaEuQQhQdRwaJd45ejJXM40JocaocuZh5ple67+enDHO98i4WhgUQi5QufzhUstxGl74HlujlVQq6UUaoyEVnkpDm/+xk4f3jWgnwITdC8Dfx6bxx4BNMiuYevD0Pfk8BTy5wLWVHg4jZmxnehfyayAAOGu8GuKVNigil44utLoK3rigickspPvEYFImG7aHU/Ll054B7E9m5HVsvzA/SlhDi/xsYK72VOaCoOYpInfg0RgoHKKd2JlbfztQqtvvQK8t3hxaZwuEtxvpYJE8inCrnP/kST2Pg5ezRD1cL6iFJyql0O6rhT8IUhdv7rVteMt1omOfx8quSxqKgeBrlWel6Ovo8poirjhiQZxpOP4r9e+48q8G6XcVVNgLIBg1g1NOMUqaUOPMVHvp6H+Vuuc1mLg4zxkNzlkDw4QqL3P5le+DQHrXweugshIYQyfbTj9923Ba7YXWQFemGUBAUlspGZV+QhkT+FYiBkBRoNraO7UFeFeCdU9dzbBhhk0dv4QeLqezZjefD7Rk6+G0xrQ33JzdSFXMQq744cHWXOPe1GBk2Z9/ddVoFuH/A+ip+1uKxQTsiV4psqRs3TAkGItd4nEco4mX3csbodEdNTAGpytdWTfLNIhMnxHMCvM7qrSQhbPh7DKpEcSdX4lLsUEbL86Muvx5TmnU6wsjcg7o1/q30MMqHWBqyX6EiLQOTd/86NBy0LkodO6HkdU0xUXLBy4cCP7UyqLpUJXglcMaCPvkJrt3HPoCbonBccIVYP9mfzbZLEEtv6DxQGpf+eX5CMQFxoXItYQAfqMvhXToSIORSVtkLFOfZ3AMp4jHFAyGxXr5GKXegv26+K5NZXIkFkdWArvordkf/2igEbDewxNGHQKUgBNMLwA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dd3dc9-a313-4385-869f-08db89342e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 15:15:41.2738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sdeo10u2+ZnmIsL1Zyvk1ek4rbs30439qS7eZiVmM7R3JzOMua5Akwf3wJ4/6It4I+fSaKHo0eDsUxoxM3YRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200128
X-Proofpoint-GUID: hm8_7i0AO56xmqm1KDSrIL4OuTEWDQmO
X-Proofpoint-ORIG-GUID: hm8_7i0AO56xmqm1KDSrIL4OuTEWDQmO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 20, 2023, at 10:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> At one time, nfsd would scrape inode information directly out of struct
> inode in order to populate the change_info4. At that time, the BUG_ON in
> set_change_info made some sense, since having it unset meant a coding
> error.
>=20
> More recently, it calls vfs_getattr to get this information, which can
> fail. If that fails, fh_pre_saved can end up not being set. While this
> situation is unfortunate, we don't need to crash the box.

I'm always happy to get rid of a BUG_ON(). But I'm not sure even
a warning is necessary in this case. It's not likely that it's
a software bug or something that the server administrator can
do something about.

Can you elaborate on why the vfs_getattr() might fail? Eg, how
was it failing in 2223560 ?


> Move set_change_info to nfs4proc.c since all of the callers are there.
> Revise the condition for setting "atomic" to also check for
> fh_pre_saved. Drop the BUG_ON and make it a WARN_ON, and just have it
> zero out both change_attr4s when this occurs.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2223560
> Reported-by: Boyang Xue <bxue@redhat.com>

checkpatch now wants

Reported-by:
Closes:

in that order.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++++++++
> fs/nfsd/xdr4.h     | 11 -----------
> 2 files changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d8e7a533f9d2..e6f406f27821 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -380,6 +380,36 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> return status;
> }
>=20
> +/**
> + * set_change_info - set up the change_info4 for a reply
> + * @cinfo: pointer to nfsd4_change_info to be populated
> + * @fhp: pointer to svc_fh to use as source
> + *
> + * Many operations in NFSv4 require change_info4 in the reply. This func=
tion
> + * populates that from the info that we (should!) have already collected=
. In
> + * the event that we didn't get any pre-attrs, throw a warning and just
> + * zero out both change_attr4 fields.
> + */
> +static void
> +set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
> +{
> + cinfo->atomic =3D (u32)(fhp->fh_pre_saved && fhp->fh_post_saved && !fhp=
->fh_no_atomic_attr);
> +
> + /*
> + * In the event that we couldn't fetch attributes from the
> + * server for some reason, just zero out the before and after

"From the server"? Is it only likely to fail if the exported
filesystem is an NFS mount? Or did you mean "from the filesystem" ?


> + * change values, after throwing a warning.
> + */
> + if (WARN_ON_ONCE(!fhp->fh_pre_saved)) {

Maybe you should clear ->atomic as well in this case.


> + cinfo->before_change =3D 0;
> + cinfo->after_change =3D 0;
> + return;
> + }
> +
> + cinfo->before_change =3D fhp->fh_pre_change;
> + cinfo->after_change =3D fhp->fh_post_change;
> +}
> +
> static __be32
> do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat=
e, struct nfsd4_open *open, struct svc_fh **resfh)
> {
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index b2931fdf53be..9e67f63c5f4d 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -775,17 +775,6 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op);
>=20
> #define NFS4_SVC_XDRSIZE sizeof(struct nfsd4_compoundargs)
>=20
> -static inline void
> -set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
> -{
> - BUG_ON(!fhp->fh_pre_saved);
> - cinfo->atomic =3D (u32)(fhp->fh_post_saved && !fhp->fh_no_atomic_attr);
> -
> - cinfo->before_change =3D fhp->fh_pre_change;
> - cinfo->after_change =3D fhp->fh_post_change;
> -}
> -
> -
> bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqst=
p);
> bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_strea=
m *xdr);
> bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stream=
 *xdr);
>=20
> ---
> base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
> change-id: 20230720-bz2223560-9c4690a8217b
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--
Chuck Lever


