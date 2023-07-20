Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8B75B138
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjGTO3n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGTO3m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 10:29:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43761BF7
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 07:29:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDeY7W022615;
        Thu, 20 Jul 2023 14:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NMOgGWq9YMSoZKKA3RQAuawqVxtc9v+hBH+2F7lucrs=;
 b=0lQbBYQddZt3WrlvosHjnEm1z1X6zahJNz9+9/mgJdPcCMh95EIhaYnQfJNQTB9QS7gP
 Ys81BEaCR4oa0Gmhi4Xr2JQIIhyogoyJh3+OILLxBAHwa74/fKUz0SUod2sonlPPzbso
 aOPjb5ueF+1rzYYtqhzPJ3c1EP+mxOV6s4gjZ8bk56XbW/72UlI1BfMHIhtdL+fGzseA
 TfyCqInMKbzoEaEnzxgxew+o520eicre1OthgRz6vODpYxRTSRyPuJA3moVnMU59XLqa
 WrdosG8MUOiXSRhOzDoDigSd2pHHVIEnxTvLNRkl/ghle1vqdsZ56/Jj5veclQO+vEA5 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run781vsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:29:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDs7xW000786;
        Thu, 20 Jul 2023 14:29:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8s1cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2d4aNmJOa2kRyd6Xcsxl8aq7XBDg22EKk+fLUYe7cWakgYfNY0QKrAuLYt0mLCuskUfgCXsKzYWfYi5ojywxlw0lX1D6XVLYmQEpP5T5nj6WSoiFpdbaUdYlBxdtCfndcouP3KbhJWw83GPcdt7x3MGYvdv2FBFzGNQ0jfqCPPPsV9GtVTmLxE+hhBTTZcKj0tFYhqv35/mjOND3IBPa3x4ccOqtwvmpw5sVhyeLwHQo/+gYNBe8pGY4/TX1koEqJi9R6364Ts3Q+Styar9FxUkv+HO8976XSD9n7NAoVytovRC1EnApXMJYdWGwShsEgTse+t2sKc8614uuq8wpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMOgGWq9YMSoZKKA3RQAuawqVxtc9v+hBH+2F7lucrs=;
 b=hvrH6I3WtMvhoVMGbmV9Ey+cxzCzth7bgLpBdiJdiyeYvUJOdp+do8EIlOk8GcoMr0m8MQ4oa/85eJRh8af6VPZ7l2i/CqWBEzWw955YxJSBsFgg3mJjAwTZ4cnKy1Nu8akHbp/9kVWSye2a53ZwxQQvDDs2Y8eriUmOI6YGSGJswsdOw+IJEOcsLEfxRLigHtWuitKGU27EBE+R3tjUEpmeQrU6gUtRoUHdW224lILsAP4plsLi3ndrI1DJaaUuxT0GYlc5sCAeYq7Uyb6myUNvSdUW3/k7pS6SlkZ1rYw6BkqejeLyrIQ27vWPMHjz3lIOcsZCBwSgBfpVNwYOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMOgGWq9YMSoZKKA3RQAuawqVxtc9v+hBH+2F7lucrs=;
 b=CZ+vfrSI7g1Vst6kva6nw5nSd4o59tG87zSM5xeDlEHQ02VeeQGDbC3v56E7kghw7Vy29QoDACAVHc8PTOuFVzkmy7zDVer/l/hDkuSPyFu87PrM9R9ZgAh9+FXcJVocXfaH1K8V/+eko/DfCqPjcSo+gfZlNKy/FiAM4/HYWD4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 14:29:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 14:29:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Topic: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Index: AQHZuUKpaE3Yn0PdG0Ko1CF5yZZwz6+/jVSAgAC9awCAAMgaAIAAqcoAgAAG4ACAAPceAA==
Date:   Thu, 20 Jul 2023 14:29:33 +0000
Message-ID: <3A9F5306-EAEE-427C-80D2-E0CD81212238@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228866.11075.18415964365983945832.stgit@noble.brown>
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
 <168972938409.11078.8409356274248659649@noble.neil.brown.name>
 <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>
 <168980881867.11078.6059884952065090216@noble.neil.brown.name>
 <E93923C4-080B-4B43-9A3B-28A233BF5DFC@oracle.com>
In-Reply-To: <E93923C4-080B-4B43-9A3B-28A233BF5DFC@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4901:EE_
x-ms-office365-filtering-correlation-id: 6c9b366b-264c-4451-a4bc-08db892dbc75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wue7b7H1VUnRkkmIpt4ewx4jSDVxrtX74fcL4BbZ4E8o1AfQYT46SBguP+lNmi+5hdlVwmxg7hvOQIK+IXTtdg+Kzanl3ik5lemoCY3dAsai0PBDuEoIk69omIvj3ELwYPPTZQt5RQe6ewUQrxSFnzLi9KMrbCMmb298J2pqLrXxzlyrGX+CsCnWZAeQvBABitcVmnV0Lit6KshRhAe6lBalH0DPxWHjdflIFvd6ssdiX5JTAvftiRXWPfGSLt1ASvYlGrJL76R2DH3GVXVLq1pyyXVHAk1tm7hVhLoEmxvASSCEmOyeGm62r1Fkm9QVfqDYtF5BKl6eshexQDvy/GS1hEq7E8D3sWuxUSso7BjE+6z67/EIXWQQ/og6vaZp4rcAcH3U6UFXZRSztQ19KuTixAqGRydzFnnO0AsiaoC/ncwdofM1zrW/fMN8yikHqnj2R3dKvWc0iH5QJMaHP3ZcCYLIo0ePNLvDxtP+JSYP5WfyGg7YXR9zUASESjW6MCGgJiL7AGVOz357cowgbp3pFmUJL+dDFogoSJELEG9Ky9s7FoEgZ3KYRv68P7PgmnFu/7kuX0zeO3Ho6FnlEZwX7kOFQ5ctF+XvMfzzs/8Vgh8YWX+TWljsOIX2T/4TNWzPv0WPEOZMwhPiO2jVUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(36756003)(38070700005)(86362001)(33656002)(91956017)(54906003)(6486002)(478600001)(38100700002)(122000001)(83380400001)(6506007)(2616005)(53546011)(186003)(26005)(6512007)(966005)(8936002)(5660300002)(71200400001)(8676002)(76116006)(66946007)(6916009)(2906002)(316002)(64756008)(66556008)(41300700001)(66476007)(66446008)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X+0peeQoWuLHF9DJbhDt4lWZglOpxJT4Sc3hAK4X9r28pH4ueAi9RAQtJDZJ?=
 =?us-ascii?Q?MFz+e0o4euNNWVOTaDL8SSwEeJNoI8YUmnFsZ+p8tN0rcXhmlYvTgjn6pjfa?=
 =?us-ascii?Q?Zi4gkiAqfF0jnxCutU8Y2fut+igkidlGqolJN0q67vTlxqWbjIA0j7/0p7qL?=
 =?us-ascii?Q?xxFmDFzteIccH4HZplZD3pmhe2MU3T1aAEDHKBPT2N0fJuzk2wDQOFcROtP2?=
 =?us-ascii?Q?SNxavLze46W+1WoiAMsjUsIIGzLHo9szgrS/GY+8Zn9m1C8ybaB7lWBXUc9h?=
 =?us-ascii?Q?+ucNBtzQAZu4GB9iPK9g3rrBexRqWDaNgdq1RNOT/nMZ388DGP/kmFNcxzzl?=
 =?us-ascii?Q?dNDbRooo3yAQMyKu44OzExtXELxwVtFpzg3Q2/rO1zTm6bmU+MSSYqG4hp/P?=
 =?us-ascii?Q?8MCs6yF5DtIwyMYls6BXMECMZz+1FrDcs+0M6yPJrmQuDtFntyPbdg2ohi5R?=
 =?us-ascii?Q?QXSlMFdaIgRlxwWoUkKs/9yEFidf6FNjxPNQWpXSD94c9GczON788afMHlsW?=
 =?us-ascii?Q?QzPU4LfrlQPllX7/K3i0guQU3vgxT2gTv1rtMiNz8aQ06EMxeDagjkygvSN1?=
 =?us-ascii?Q?fLNsR2FOoZb1Uw9uvb7pdE5xltd15p3zub63z1SNS7jiyFjQq35NpbwLd34Q?=
 =?us-ascii?Q?jAYUCEIpYtWQa1R+UZlCbHProZC+6J6i3tMmD+RUjmsuh1s4AZOlURjTMqmh?=
 =?us-ascii?Q?McE1qIfN8ShCIVNC7XZm9tGjZ2pm/USmnio56I22OGZljp//RGkyMf6a+8Un?=
 =?us-ascii?Q?9I7feGWBI7WPM+wTfNStj6L16c50SUT0a5XCssA/JeXq0XY/GffG9ZJ/I/I0?=
 =?us-ascii?Q?6cXrQpr8cRb7HDR13SsZA/CuNCwbV6NdXticXpulYBOJRfqUpujYHdB0OBAp?=
 =?us-ascii?Q?yvitWlyD0BEJLcf5AUwpYb0cERNt1QF/y6TSr135m/36lHe23vWsTA2n4KCL?=
 =?us-ascii?Q?L/pD0tyKF76nuXNDbDx8UsJ2kewAzlNimbXLs8OHaI4UdRYyWPC0vqPzCZQH?=
 =?us-ascii?Q?PJ0U+NXef0oU2x6pKgwulzB3HWbhNFbTtXW/8w1HOc1/JnvRD/BJi68yLkSV?=
 =?us-ascii?Q?5pS6snZx+zRzqc8uNTX1o/FvaFYLJ8iwm7AQo9xeWRLwYg293rJBlNnwnFE6?=
 =?us-ascii?Q?M07UQ8hW2c1AUmWShw7bBc0R6ERXKRsMFZq2ub89j6YFopt+xZeUSgFtPJ74?=
 =?us-ascii?Q?3ef018OntoXHZ/w6guDEQl9thYI9pMbD8Z4VkdzifrKbOw/lK+4/GL1y/gEZ?=
 =?us-ascii?Q?2MZq/sNxDqAL8dXd3kPK6UPE2aHYt5t3ccTb6NfO7sXiUY6NA1pP+HuCS6E8?=
 =?us-ascii?Q?9NWv18/NhKNuncOZlIKgvYFM0Z87i9ljNaFJnzTmIsPrU4kL2VAChYxL5UhN?=
 =?us-ascii?Q?IwZTDmYVqW0ricm/KudhXwVr6Hr+XuaPc10P/QaNDHSuGAZN2XdsIvpDOY1e?=
 =?us-ascii?Q?cInpHdKBMt/fu41Jg4M/7nINRgU4oB41sZMeLL5ddGBxF0LIPY39cGmgl/yf?=
 =?us-ascii?Q?3VqslHirk9LLRpHMZXPEwUthJp7JHaQIHO+By8z2HK6SbXDyylEizspH0c5h?=
 =?us-ascii?Q?xAW5QASd/TUd1zLbfee28GKK0Lu9HWeHyYXXalgibdkqaz6mkRTbjPCFTMdV?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C628877E46336E4C9E82A25CF0B3E470@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3KnTakd1hJuuDwqy4Dy1ydxf0m+7ge0ddwsWkK4/9c4JUoDXANlLI1vppokUjFj9BALj5iuqftkWDu4/9CyRuh28kwH2qGrCRkKxepMKen+OPWEktodSGptP2Sxv5TI1eY9FIUS+1UNW5nlu9bqDuEsVk4O2ZqWmVEgfkPI7wdUvfstCSCd5X1H2XMVD/YBU1/rLtJ2broGHn7fkJ2GmXIgi4VlkfRxZv1jbH5i0L0Ty9HAgK9Gi7QxFAivp4j3OiVs6nGE2DqP43gd26lxDO4q4SqkuZVIMyHm1SNHcyLwew71S4HvFSkBYIq7tVcHRr6WCZaG88J4/30iq9r3ktodHcWIRYpnpfwrxMeq4MI+beIursvHCKbB+IYf1hkRcFxiuDJxkht5AxL8qhxTIzkqcq8GhTHhkmvexG4/5jJ7Uoii4RdmFK+pgGbKRqIVyLGBoS+rhDKF790kDxm/QCwdwdyMr/A8i2aubzUQ8vixifh+U9v+LGm6opcAPEa8MG+UNv1ilmtlWhgWE/ST9I/ft4B9Cq9nk3/B3tE2nul7vZYWxr7yi9QnlCIFdT8xm8tcYX/E65smbZ+224pP5qh5ZD/vy+pMaeMtbvMImm7HEnra6zvNfDLlpQKYciU7qFFHHiBLV0TN+iRSuH/fAt0sxp9ScYrxMfBNRB800z/2uvJa+kv6kr8/InFAmMU89GCcNGrYJb8UbGpqyXz3dRLUpL+E3ADBYqAv2jciXEHtSuXi82P6mrtwTyezjDiACJ7cDidEMrC4IgeGnmW9XNQjPWoT+Je9MUSwvr6sWmeidwbY5X/jmmdHE4sh7TQh5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9b366b-264c-4451-a4bc-08db892dbc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 14:29:33.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H62vZJf6V3r7frnJyQx4PKteUpDlNQAETCYzR7GZL9E/sxxnqVQ275I225X7kDNWVXKyHuI8Ora44K4oSTXKnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200122
X-Proofpoint-GUID: k7gINPYtzZAoL1UjiTqpf5Ih5JNKAjcF
X-Proofpoint-ORIG-GUID: k7gINPYtzZAoL1UjiTqpf5Ih5JNKAjcF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 19, 2023, at 7:44 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 19, 2023, at 7:20 PM, NeilBrown <neilb@suse.de> wrote:
>>=20
>> On Wed, 19 Jul 2023, Chuck Lever III wrote:
>>>=20
>>>> On Jul 18, 2023, at 9:16 PM, NeilBrown <neilb@suse.de> wrote:
>>>>=20
>>>> On Tue, 18 Jul 2023, Chuck Lever wrote:
>>>>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>>>>> No callers of svc_pool_wake_idle_thread() care which thread was woke=
n -
>>>>>> except one that wants to trace the wakeup.  For now we drop that
>>>>>> tracepoint.
>>>>>=20
>>>>> That's an important tracepoint, IMO.
>>>>>=20
>>>>> It might be better to have svc_pool_wake_idle_thread() return void
>>>>> right from it's introduction, and move the tracepoint into that
>>>>> function. I can do that and respin if you agree.
>>>>=20
>>>> Mostly I agree.
>>>>=20
>>>> It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
>>>> as there would be no code that can see both the trigger xprt, and the
>>>> woken rqst.
>>>>=20
>>>> I also wonder if having the trace point when the wake-up is requested
>>>> makes any sense, as there is no guarantee that thread with handle that
>>>> xprt.
>>>>=20
>>>> Maybe the trace point should report when the xprt is dequeued.  i.e.
>>>> maybe trace_svc_pool_awoken() should report the pid, and we could have
>>>> trace_svc_xprt_enqueue() only report the xprt, not the rqst.
>>>=20
>>> I'll come up with something that rearranges the tracepoints so that
>>> svc_pool_wake_idle_thread() can return void.
>>=20
>> My current draft code has svc_pool_wake_idle_thread() returning bool -
>> if it found something to wake up - purely for logging.
>=20
> This is also where I have ended up. I'll post an update probably tomorrow
> my time. Too much other stuff going on to finish it today.

Pushed to https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
in branch topic-sunrpc-thread-scheduling


>> I think it is worth logging whether an event triggered a wake up or not,
>> and which event did that.
>=20
> Agreed. I have some experimental code that records _RET_IP_ of the caller
> of svc_xprt_enqueue(), but again it's questionable whether that is of
> long term value.
>=20
>=20
>> I'm less you that the pid is relevant.  But
>> as you say - this will probably become clearer as the code settles down.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>>=20
>>>=20
>>> svc_pool_wake_idle_thread() can save the waker's PID in svc_rqst
>>> somewhere, for example. The dequeue tracepoint can then report that
>>> (if it's still interesting when we're all done with this work).
>>>=20
>>>=20
>>> --
>>> Chuck Lever
>=20
>=20
> --
> Chuck Lever


--
Chuck Lever


