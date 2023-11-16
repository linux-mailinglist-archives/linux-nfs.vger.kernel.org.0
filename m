Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99B7EE2F8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKPOgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbjKPOgc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 09:36:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4668D181
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 06:36:29 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGETZus022621;
        Thu, 16 Nov 2023 14:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mBjUVB9bXDZZiOlyDisZmh0k3+T+X9iCkWjxThqfflM=;
 b=N3TWwiIhb7C0OO7Yro+FcEBd3cyxOSWymXuWfpG4iVL7ZKPDJJXBl7tTOcvNgaxo8nn9
 IlLdEt6BLGoh++z7wq9+Qb7o16E4HRBRiDjMn/JwV90r59H4XUd4AeR86HZ7mM3z6/em
 XxTtkpLOapL4aV5ZQygFcMmUf1hJz1OUEMC9FlkQ2yiY8mWZKTnBWnpYJ5xTawBfue4d
 O3aTcjFKQGhB1Vll5kYFnh5+I70TbMnl4dyKNs+Ei8JXXq493qbzBhRc3fK1jaeDOGy+
 dHavM+C0GyptZZhnpLqLVdZwn91x9YQMNJIvkV2pvXKjBxKd7ttSuJaKEF0mj6fpr2QI Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stu5sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 14:36:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGDbdsK036936;
        Thu, 16 Nov 2023 14:36:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k6y9u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 14:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKlFYbE0DZpcLQfRuhvopDBt35EZ6XwDyH7HImfoAjAiOMujsRZl0lGjd0pkBvhi6Y5iVYx6PPLoWuqkLvtZK/e0z6gXrmq+uj8Q1QsCYLU2d6fP/8Hv2UneMesu7uRy49lSzc8SirAFX7GeTOmPPcX+IL6OYevfEBgvr8h3s3U+eO3QCjBxQ7El4CZDpUaVLh/4tO5YhjB2locgu90gLRmUbYBgjH3uvtCtRJIvbxxbsl1G4yuyt+hcRevZuGh+G8B1YylW650cAtJpUO0l5Leh/97sOpWle9VSU92O1K45PiRpvPu7bff/1B7vyc08n9XKkULhfOFi/d62UQ6oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBjUVB9bXDZZiOlyDisZmh0k3+T+X9iCkWjxThqfflM=;
 b=d8jDCBNdDTUsT6d71kE5196DZfgr49CI3j6hYiT6GddKPiEtHfBiI41qGtItfxhssyJF1K+EN8oOXSQ272p16Jz9QF6PszqLrdgzTLMCvthCx+NGTt4nqGLyrNeayp4oVzFgZ40T1ervlHylVvff8KhAM8u5vgg5ouUTsuWlzrdDdwMjhq0OqkI1kOZkeHimqkHY3Ui6WMkG9RdPOxProirxpQNBLFftwyrlGJi0CsadUE63NpvIE8abIU1ouMGfpZsmdpT3YcSfVmv3Pos2x8ufpvaA4dAci5D9iX7+gKGfTjbH5Igoi4wW8MiGjzLG7actfNiQqrXhY6C0rN7hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBjUVB9bXDZZiOlyDisZmh0k3+T+X9iCkWjxThqfflM=;
 b=uVdaotFzBFKgUM7nzObrxXrlVBHv/p6jVH0wd9Th0cClYDRNYxHJ3C3a8byjJ4F1SlU67TIev4w0hTqNZTb0jHHrssQsbZFH3w/mo+33L5gBqnhkQqosUyUllsfh5CcaiyIsi7VyWIaQIXKtB2vT9g5LThC3A6rOFEDORwYgrVo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 14:36:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 14:36:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Filesystem test suite for NFSv4?
Thread-Topic: Filesystem test suite for NFSv4?
Thread-Index: AQHaE/+ULy5n86GOM0WOE7aV3pGUDLB8jqkAgAAN6gCAAG/mAA==
Date:   Thu, 16 Nov 2023 14:36:18 +0000
Message-ID: <C337A1C9-A1DF-4F65-9E69-2522A3144A94@oracle.com>
References: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
 <CANH4o6Na-KPweTmeUAiU9sK4OGt8RkkZU+vK5xpEe-BrP-s_Bg@mail.gmail.com>
 <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
In-Reply-To: <761568108.788363.1700121338355.JavaMail.zimbra@desy.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6535:EE_
x-ms-office365-filtering-correlation-id: ef5434d6-89e9-40bf-5765-08dbe6b16568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3r/dOOf0/PjUWRnrN2AdVWCpmZ23x+ZjG5MMkBmKbV4M8+aiTY7PP/ibOHJTSOkDpQhM79IA/KsGZbxfXoL+k8LiMsvmwc7PfjUwXjqvHo5h1IZ/BD8aCb88xZ2AAbCiulEXgdqwgYsfdHqhG2SaRb+ye69sAws69b1Xw6WVxRS3Lpe+lKCbTNfTBfcvF8DMStxRMqg56DerjqrnNuY+ecVAog8gezu/lqck92evkBS+AJpXDVNjkz3aCAGSoGvbYTzyTu0ax4nJvA/CSTnvq52uKtwBbXauTBNr3xcR8iazGrAbie0ZrIxTtyLZASRTETEbJdTnWPonME/iWUv3upkg4ibCmutUmv23c0lLPlHz8SwaOneAYiWiw3sDv7um4xbtRlR4GnX15aFnInAZ/KLvKZIMGc2upk6bgsRzTeXRZNTmXVdrUqKRIp0kfPbUk3BRFk8/UzHEUBMqbMOTzpJxEprjsegMF6LHqutfoQRgFalyFOhY8bqFcvTwUpqQUiDua71t0Ts4nsct0m1Y/kkUZrI5W5TeBlm6nmyHENXUcx0c7Bs4UK0CQVO04XniCy4t7Q1ObCvs0WXRTnI2cbzmiTHqaYc0BQQF0ZrwgnjLgkmesHcWKIzEBzpuqEkVLfYLOFP174aNZaVu60ngw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6486002)(966005)(66946007)(54906003)(316002)(478600001)(76116006)(66556008)(66446008)(91956017)(64756008)(6916009)(66476007)(8676002)(8936002)(71200400001)(5660300002)(6506007)(6512007)(4326008)(86362001)(41300700001)(83380400001)(33656002)(2616005)(26005)(36756003)(38070700009)(38100700002)(53546011)(4744005)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGMxKy9tRFhiSTFUTHY2NVJrdUMxQ2ZRdnY4bnorbnh2dWZOZFRYT3NDbHF0?=
 =?utf-8?B?Z1hsRS9YeG0yald4bExmLzNCZUdZazR4by9HUlBXcExEMnpUSG9sNmFEMUxl?=
 =?utf-8?B?Um9JR3hGQXEzaW1nenRqbjdEaU9CVnU5TUhGeHhzUTNZY1FnMUIrbVBVbjY1?=
 =?utf-8?B?Y09oOHhmbjhxOWZWdldwZm45ajJ3Y281aTZOakdnemNnK2JUSVhVVGR1Wjl2?=
 =?utf-8?B?WnVFbFZXLzJKRkI1V1RHL29lRytnRnN4QmdmenpoTW8xY1IrU2JCZW10Rnhu?=
 =?utf-8?B?TUROWXlFd0d6ZHdWenVwSU14TTVxVW8rMVRpcDBZVGZaM1FkWXNmMlkxMFlr?=
 =?utf-8?B?TnRBMy90bFprVmN4V1VVK3VmWXU5dEhrNDByZDl6aStpQjVmRllDQ29JcStq?=
 =?utf-8?B?anJjZ1dMZTNNdVQvK0tNRGtqZG12SnVTYTBpVDQxb2FLVVl6VWJ4bnBFZlpi?=
 =?utf-8?B?c3dSV2F2b29MRUxBNnNnSUpEeFBMT2JIOGhHMWExQnRXRVNha01mTnd6cGdZ?=
 =?utf-8?B?WGsxN21SNmhFQzFqbG1Zei9DVjZ1Qm8yeitVc0ZvSDVRUFpHRzVIblBtK05K?=
 =?utf-8?B?b0F1S2loVFFTN1BtdENnM3cyaWs2YUoxRUhVTlBlUndueU1hMURSRitQVWtz?=
 =?utf-8?B?ZDJDWjd1elNuZDYzNnBtWDVjR2lJQXo5YTl1R2p1SS9YdFFZWnh4czlvTFpn?=
 =?utf-8?B?b2JlQ0hDcTl5NHhBVmY0WFJESTF2RU9yWDZMeXBjR2NZVXVhKytkbUdNNVlz?=
 =?utf-8?B?eXJhTSs0ZXNPK3RMZXZvd3ZSM05URzdKUXVQQVlSbjF3L0REdGF6WlhEcjRl?=
 =?utf-8?B?dCtvNEJOck92RlBYU2YyOHRDSFpvS2tTbUUxdE5Mb3k4Qkk5N1pBRmhkci9q?=
 =?utf-8?B?MUs0YmE3aTRKekt2dER5NDZaUFk4WkkxRDFhZGdjOW1ISEpYQlBwendPMTZH?=
 =?utf-8?B?MFRxOUZHZTNHclpSVHJqQXh2Yzg4SjQreXVoUHF4Z3ZDd0U0QTZvRTd5VDRa?=
 =?utf-8?B?Um9XZnlhNFBzN2pBWnZMRFpmZ2J1YTBEekh2elZzUUtNVnNXOVp1RmkySnUw?=
 =?utf-8?B?L2x0NEROTmNMTzNKbTF4d053aTZ1a1ZTc29Hekd6YlNsYmVveVR3bWM0Z24y?=
 =?utf-8?B?dlR6eUZ0TS9EYkVkMGNGem5YenBUN1RNOEpZOGFTZlppbHl0OXdTRXgzTjll?=
 =?utf-8?B?RDY4NlJxVkRkVTdGS2ViSXFkWXo4RjJjTmo5VDVUcVZNSmFJbkFSc25uK25p?=
 =?utf-8?B?dlMvMWtRVzd0MXF0d1AvRnh4U2NYNXVjcmhzZktad0JIWkpoZG9sWDBWQlF2?=
 =?utf-8?B?THpud25QQ2k0NWgyeWhBMnNibUw4OUFSeVZoODVhZUFCMVVuUGkwSzdTRjQr?=
 =?utf-8?B?RGdvSzV1akVXbXFRdDhvRTdyaE51WndMUUtZR0wwNGlaazVkY05BbjZXdURB?=
 =?utf-8?B?UzMyak5Ya0U3VUF2anJTN3dPSW9KRjgwR0lTTmxPSjRFd0kyNXVReTlSNGZ6?=
 =?utf-8?B?cGtRcWdVaElnY1cxcHp3MlhwNEdVVEttMHdMQmFuVXFTWEVSZXhDZHN6SkZL?=
 =?utf-8?B?cng5ZnhiY21iYWpyenl2V2RmejdMVTBjQTE0TnExZ1RpQVJubDk0V1RQQW9x?=
 =?utf-8?B?UFJQWHZ0TERxdk5pTkJzejcxSjdSWm1hSFRIRGxGTG93Sk50TTdQL2dkMG5q?=
 =?utf-8?B?eHNyaUo3MXMyUmJoU3Vrd1B6TXgyc0hXc25YYmlRVGxYaGN5NGxpTXF0Rjlv?=
 =?utf-8?B?QzNEeDhtRVhFak9TNEU5a1YxTTFTNnJlRFhpSHoxMTdsVEUzTEtaWkUvRGxz?=
 =?utf-8?B?QXJldmpWKzBQMjhRV096MTFZUUJQdnBLcVhkKzgzb0lTZ0dMNnlKbktBSWdv?=
 =?utf-8?B?T0JWR0dkVVFsU0JKU1FibEQxY0xqaDljNWNidEFBUUZWRS9vZjNrWUhHRXE0?=
 =?utf-8?B?RGowWGZ3WjNPTXNTMTNiNitSeDNTeXBiTzRwZmpjMWdHUDZWQlllZUpENFhh?=
 =?utf-8?B?Nlc0bjRBaWxEcmtJUE9ZUm1QbXljenF3N2VLbWlyYnFUTm1KZTBxd09FbGJR?=
 =?utf-8?B?ZndlVEF5WGU3WDdCUXR4QWhiNGJ5TUN4SUNqZ3pIYVg5SGxZbjk2Z0FIeEx0?=
 =?utf-8?B?ZG1SQTdseE91di9oNE0vUFNVcE5hR0oycG9HMW1QY2xVMmF3T0pZNEFWb2RF?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E06908E227F66049B564653106C0F919@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O3FQMpg9qSIy9HApWXHgxtormbEg8tDx56Qu/y0wDT+JcbRWhrd92vetcvA9XMBdyQPsQDvbnsNyXlNIWbGY6ogp2sBiZ3RCeK7eOoVjf8stQUHEs7D+/6sHwXHhDlLhowvb17qEUvk7Di34CDcdkEVkvGuIC8IKZjoMXjLJlAoUWDc8umARtdXvRxVpETHHZUQyeyTOHrO+W2jnyyt+Kn475nrID8d2JLK9f6UkuN3qZVEeBvOwYwYJ8wXLovjDUdJsICm2iDorVdJS2ZwTA5R3YUU+q0t0gm7PLspeayzz3qCniQJ9A57G/fGNvx5+gPhppvRBMZsrJ9IaPxz/WXIB8M2e+VOahcNU4u866sj4fyGBswqFFC1uPiOwX49ysiOxg5CAYNgaD+IDj/nzmGwbxbu/A2YKZDbQ1zYqO7ikuYP/mRKQVEA9S7gs5phMy186skefeMbnY2hmc6aU6wQDUetIAHCL1ja+oiWEElkEIDidFWOje8C+fTWFWXJVxJcbt3a6If4/ZoJyzavgrHS28+FvImkTUpwjQRvJGtnS/Efm7p1bwyJAH7u3BXMVqXrZNTGqjejFomg5yLycTGrmSqTfwYzE/DGnxtW9OtK3ZWvu82rt7YhOeq0qZLVwPYM5K6RQnDwYqQ9wPpHE2RnXmOyWgGuc63U/7ES/MidoLPpeSFPOEjIKHTy/aLc2VlZ2eOprpOcyB1TbuI+h3lEBCFY8NBQ4MMEH1m7JwVEPLc/rDDfamAxYNWZt9EvNUvdbXv7b5PJCaN6E/uuQYaLRy/H+n8ir0/GlUlIkINZd+sN2B2ldIOYXpIpIZu7q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5434d6-89e9-40bf-5765-08dbe6b16568
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 14:36:18.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: us9jiD1K5hMorkzICNFijG9/5Ws1UrPB4R+DahxXNwkTcipNF9cbJDYKgnNRCzq6JNRJSScIGyQudzRTFWLpkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_14,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160114
X-Proofpoint-GUID: zN0-cytS5qBwJONtTmIP98vScmL34DDB
X-Proofpoint-ORIG-GUID: zN0-cytS5qBwJONtTmIP98vScmL34DDB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDE2LCAyMDIzLCBhdCAyOjU14oCvQU0sIE1rcnRjaHlhbiwgVGlncmFuIDx0
aWdyYW4ubWtydGNoeWFuQGRlc3kuZGU+IHdyb3RlOg0KPiANCj4gDQo+IFdoYXQgZG8geW91IHdh
bnQgdG8gdGVzdD8NCj4gUHJvdG9jb2wtbGV2ZWwgdGVzdCBjYW4gYmUgcGVyZm9ybWVkIHdpdGgg
cHluZnM6DQo+IA0KPiBodHRwczovL2dpdC5saW51eC1uZnMub3JnLz9wPWNkbWFja2F5L3B5bmZz
LmdpdDthPXN1bW1hcnkNCg0KcHluZnMgbmVlZHMgdG8gcnVuIGFzIHJvb3QsIEkgdGhpbmsuIFRo
YXQncyB3aHkgSSBoYXZlbid0DQptZW50aW9uZWQgaXQgaGVyZS4gU2FtZSB3aXRoIHhmc3Rlc3Rz
Lg0KDQpFdmVuIGN0aG9uMDQgd2FudHMgdG8gaGF2ZSByb290LCBidXQgdGhhdCdzIGp1c3Qgc28g
aXQgY2FuDQpkbyBtb3VudC91bm1vdW50IGluIGl0cyBzY3JpcHRzLg0KDQoNCj4gSU8gYmFuZHdp
ZHRoIGFuZCBsYXRlbmN5IHRlc3RzIGNhbiBiZSBwZXJmb3JtZWQgaW9yIG9yIGZpby4NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gICBUaWdyYW4uDQo+IA0KPiANCj4gLS0tLS0gT3JpZ2luYWwgTWVz
c2FnZSAtLS0tLQ0KPj4gRnJvbTogIk1hcnRpbiBXZWdlIiA8bWFydGluLmwud2VnZUBnbWFpbC5j
b20+DQo+PiBUbzogIkxpbnV4IE5GUyBNYWlsaW5nIExpc3QiIDxsaW51eC1uZnNAdmdlci5rZXJu
ZWwub3JnPg0KPj4gU2VudDogVGh1cnNkYXksIDE2IE5vdmVtYmVyLCAyMDIzIDA4OjA1OjUwDQo+
PiBTdWJqZWN0OiBSZTogRmlsZXN5c3RlbSB0ZXN0IHN1aXRlIGZvciBORlN2ND8NCj4gDQo+PiA/
DQo+PiANCj4+IE9uIEZyaSwgTm92IDEwLCAyMDIzIGF0IDg6NDLigK9BTSBNYXJ0aW4gV2VnZSA8
bWFydGluLmwud2VnZUBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEhlbGxvLA0KPj4+IA0K
Pj4+IElzIHRoZXJlIGEgZmlsZXN5c3RlbSB0ZXN0IHN1aXRlIGZvciBORlN2NCwgd2hpY2ggY2Fu
IGJlIHVzZWQgYnkgYQ0KPj4+IG5vbi1yb290IHVzZXIgZm9yIHRlc3Rpbmc/DQo+Pj4gDQo+Pj4g
VGhhbmtzLA0KPj4+IE1hcnRpbg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
