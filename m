Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498F662C68
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 18:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjAIROF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 12:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbjAIRNB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 12:13:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F115F2C;
        Mon,  9 Jan 2023 09:12:01 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309H5LfT023618;
        Mon, 9 Jan 2023 17:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cfQQnQsJx6ps/ipZITgRsydW+jJjt/iumzEF8iDZpWU=;
 b=swhnUj5hwQxmX2j08rGWlLWwMMUzMfJ3DF17gC/88udsxeV8c7jnai1e4gnCmB5AXcY8
 lNhFhqgSrpPXE2E9QnV7vQg/Imb42KJzP1TSec1mLMLUIWPSJvHqQSQROqKI+/Guzqra
 AcJFC5ZN7bpulXOpBdLU+jnLnKY2z8hxOXKMdjFy4w1KlttxyBAdsQywaHw57e64iBbx
 ZrKTz8AhmboDMAhqxWoIOIbkeR5g6t072SV20pNeUCIpFAyFkt3JLKauSlIK5hjDZnbJ
 ifAe0/xB5SgztEhQIRe0rdn2zR1Yv2DIXg71a4ko2Bahye2HjUD5wPeyMRNa7H4rhOZ4 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0nn10a5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 17:11:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309H5LDw002438;
        Mon, 9 Jan 2023 17:11:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy649s6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 17:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk3lQ/iOG2sn+NTiLVqzUvyteZWnjFMgjpk9aRMmUwQ9ZZF3zLsR/oOGr7jkrbn9v5xuUeG3Ruzxrq23yi/Z03HYlI6Jf2Rb1FU28svMnR39KksADsSob4qPKLY1JrtMVdNsg4/oja4RVF4eOzONVgT5vLDHSkpedWYF+nd8G+kZOyYq+ucJO0x71oDwsFiOvbnhQFKJQHVFh3UCUo6MoVyHiC8MAJoJ9ZdAmwYXTtcvkfiMRxSmR/sk5vioiQ93tk2CU3NBHRxsiFcMl1ptBMxp4U3PFb/yw444QzG+h0CnCX2RbJBUsezmLC2iw2fkbjbrsafcI9NLDaVnBPw/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfQQnQsJx6ps/ipZITgRsydW+jJjt/iumzEF8iDZpWU=;
 b=khw1nITA/84+jYl8hJtLCuAxKWC/RAn7Fgj4KJGKLhnk7+kWH0iKyNOji7gKBckoPZ7Llx4FfJ0SE9lNGOty1CGpRquMXga77FZ8cxNp+QT4/WroAnwF1yz4B/DUNmHWJ/7YNpDlPwp/zHWI/QcHNrGJ4X1zAP1qIgbSKZlVhKcgs8NsXYPonTKCSOG9WaXY9mC4EdFzywLOBZSDBj5/JSezn1NfZKpUPtznlS8ryb6r2x7jUmxqSN9DxqV9ChhvCRpoSiLx/HQbE9zJ2kAa0UKndPT0GKrKzJrvF5W6VMcLMeb4QQjjlqZ2qShNZcfNtyRwGHbSjm7jLsnehZbKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfQQnQsJx6ps/ipZITgRsydW+jJjt/iumzEF8iDZpWU=;
 b=yPL0/292YrFIUcXW9ReqVrcaoHGHZGPjSO9xPW43VrR8Fo0FIonMmTUBDThZZZYWTTHLs0Xbw/+SpS8TeHsANEaaShtg/wWVW47cbxNUvw+dsNj/Iq/b7kg7CvbeQ7oX+sXi9K9RZOr9RtvzePTq/AG/+ukXKGztkuVTZblL06E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6413.namprd10.prod.outlook.com (2603:10b6:806:258::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 17:11:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 17:11:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Topic: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
Thread-Index: AQHZIq8GJkROOS2NVU+FmVsgVWlM/a6UhAWAgAA+nYCAAPy6AIAAB+QAgABlFgCAAAaNgIAACKyAgAAZ/wA=
Date:   Mon, 9 Jan 2023 17:11:50 +0000
Message-ID: <537596E2-2D63-4042-A308-5720C41B5DBE@oracle.com>
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com>
 <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
 <1B9DE484-2543-44CC-83DB-46A3A9A9BEA9@hammerspace.com>
In-Reply-To: <1B9DE484-2543-44CC-83DB-46A3A9A9BEA9@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6413:EE_
x-ms-office365-filtering-correlation-id: f81c1d20-5565-4e4a-e27d-08daf264992a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6g9B28a35GwfaZQObCaIfY5G9vadOVbUdTHuVRSNG8aOb5fptQ9W3/VbdwcdWNp72IltOEZmB/LJC+SpmF0LdAAthY1dUjDwcrg0PGYPem79cUY8Kdm+3Gnxa6lWU9z/59oKcP6Q41h+S4QDphQQUgl18snaq0QZwOAXSo1BuKk+TvFwXHRHOFVmkRIkvG4GGBNiZTT9c3+wWJJ8GWwi4zQEW/TR3DeIhsH04elVPhK8CvImgiq7N9MsE9iVWwpxvvz2eQAfRO/rZ6GFVUzoAVDIhCY5S2S877s2qHRd/siGzvcVltWCkVmFZImc0CKFjrifUuXaDuxhjarDznlluioXV1ZK+wCv2J+kkipeyo1eUd5BBMs+3m83+ffQr24vrtpPBDFLRv+QVnaZOrtDcBLC2ndj8StaleARvKy+HLPSIV4HGU8ZOnVZrvtFnc4WsbXdwtWjgA+sdDPK+EazCPBa59tdTIKJq6bohC50FDxeJeXg6dfreGWfxX8C3kUhmB0N3HhJPSKbOOwTUmXZEbeK7N7esmcxNyj4SFnyaaCRMWNtpwZDKieZoZEdN5pOHJL0BQdqDZ1vbrelpnT8h7RKIBtE+YFTzuJfjYeoskRI4IzHxHOdKDZwdJ7n499c182/dd3NYD6wpcas+yG60HUEven8pUmcfykjr2+T8nyVfcE/xuqShGrSfLhxtxkoIinRcjIuMEPPkZiw6BnW9vPAv8rKX/QCmSXqbKhojsUeduoPNoBeu9dye1QzRml
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(86362001)(33656002)(478600001)(54906003)(6486002)(966005)(316002)(38070700005)(36756003)(38100700002)(122000001)(83380400001)(2616005)(6506007)(186003)(26005)(6512007)(53546011)(5660300002)(66446008)(2906002)(64756008)(71200400001)(41300700001)(8676002)(91956017)(66556008)(66476007)(6916009)(8936002)(76116006)(4326008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AfFRsamKzfLUbh/KhqFmSX+s4JEkQwBbfZtqjfKL4wtxmAiC+7+nF0mDoxEp?=
 =?us-ascii?Q?zRrm2J6qdqjIUCpbUl1sNMece/spbJ5r3qrC9zU9lRTtiFVcGYvNft2qxYq4?=
 =?us-ascii?Q?4jtTmRcX+IPcf4pB4pA7EjWxUyPcA9YnrPLGWP+6sVorR71LT/3HzNn0jNZh?=
 =?us-ascii?Q?3jXrR/5+woyuxILZDjp+QTZDK3SJXfD7Q/GTglEDqOcJms78m0CmB1tjtGe4?=
 =?us-ascii?Q?wn2s/aZ2h64mnG289Qj5gPTJXMZr14241YtxFxAWin2SkOCVeRRhmE8LybJC?=
 =?us-ascii?Q?6ZwnLHDKw6IcbUql6Iw55ArRY/lPYTf9J1lB7iRUOHuN1RD9EgRnli7HQolX?=
 =?us-ascii?Q?wpAXK4edntlLbp5Qtim91MPsyJBE6lPYS37vK4eA+pWMpm4P/0BRis5vHCe/?=
 =?us-ascii?Q?AC8qfOdR92CAsDHEDHSZFRnyrymgs5h9PsgEdti+ghDvuxlV2nwMAfEm3Isk?=
 =?us-ascii?Q?UhLjANdkU1iWdEXI+gdNYjk3EcZs4+Wnz6Nq5DcC/a8UwfQNp6yzHGVXIauP?=
 =?us-ascii?Q?bnU/XwWm/JobKqG6Q/FVE1bousYeXerkK55gQodmJpe7IGL8WMCJ7tcCoYU9?=
 =?us-ascii?Q?nvEZwMfpnu8Z9t24Vrt8I50AyPoxpa4Rn/09Wv7FoL6YNTVSPQD9EXHruLj5?=
 =?us-ascii?Q?Yug7SkielP3TxAeVtU01jcZkQCS79qnDZDXq6h69dUesvM/8ZyfJrEIkS8uC?=
 =?us-ascii?Q?R0k2mNqt0WTWwdu4TX9qKPqxd7XoWU+w/GUndjAx06ZrbUf3hV3qWK+FG9mr?=
 =?us-ascii?Q?/w/2eYgj0CQWAvic8EESobX/QNznGNhCuKOtg6qFS7XWLbhINYRHIt6XSW5s?=
 =?us-ascii?Q?0kPcXWNDoEfXCpoCH0HBNsILs8My2VA8fSuMvAkEWyAkf7DNzj9u47v3FLIi?=
 =?us-ascii?Q?hIbfy/xSyr/WHS4W02zEi8eQH1rBhjTaI1Ln9GjxC0oNhJOzZo7tantsCjV6?=
 =?us-ascii?Q?Mtdz/CmLQLvZ39+r+9tb0fLpT5zCMz3WLcPzMJ47HTvSEsz8iEQdccVWKjBp?=
 =?us-ascii?Q?+tNUPI0/ALViUSabiMdyQTCk8VXGhMPkJNtnUVaMiULjuV1HDekZd0e68y+A?=
 =?us-ascii?Q?zQAoaCm64UEfvClOm1XeZu0L3ynt0DP30YyD5HLrvmEjcfNUPLtsZQ/RAmoe?=
 =?us-ascii?Q?rzKq8Z18yjR+S5NbIx1c3VDI0dcPjfAVXGcuSzHcT6LCXhWeA0FfiIwSWKbV?=
 =?us-ascii?Q?J2TnAEabpDw4TKV2Pjwzq30lxvX1qYqTef6b6Ga4cB9xREjthBTkINXrPoni?=
 =?us-ascii?Q?rqFF/i767IYyC/aPohkN/CLSAwX1g908Jp4w9ROvpG+gx5HFvuIole6uMUgl?=
 =?us-ascii?Q?j/LiKQqLbaEDomerjbUjOBeTRZDirMR3rV6SCRVxwFPi88VhFSA+CwFg08KD?=
 =?us-ascii?Q?Eyoxvy2HyxOzb7A0Yo234ATRwxyAkpQPy4/0aymAjv841ghcSnvJVtSpbUzT?=
 =?us-ascii?Q?MXtNpf7vsp5kgFfyAZgKbj2rnAvHgJm+/PHN+WeHyDWsPnHvRcP1njqzF3ZR?=
 =?us-ascii?Q?dkQHazYZ0apZxDHBOBWLBU8cC/QywCY/kLceYitwc81qWLmqhajzXolCGBE6?=
 =?us-ascii?Q?Lpu5DjZS/p+1uHo5/ZxJ44Vr+eFfFFFs2axQZn9VWnlDtoB+PiAivqNb2SqK?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E77603E103612442BB7DFCDB4EE6E910@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tmk5KP61CHQaRYgUpgibW4/yQpCJndc3Ixpcium/hcKq8ZuWeuVCXRv6+537EH58xleSnxr5wJlfcs+T8/tEDrxCojpMHU+FSVQQ+/x1HCihwlldO4pcQgCvMT61a+snFywaNv/62N4YqRheUckTzaKsEalpbPDBYkY48S43ipA16O5depazrwmgbsYtLeLsd9tZDJ93PPPlrAStnIW6a/+xnaKYgyDsYCrPmNsvNMStF8w/mtyNg2tMI8Q60pxNp2d5NuTM8FOw+sPifxATHk/iSi7797SeBQRbHQ/w6QSYKruCIHjpEVESt4fWwBYlkMPUWQJnw5XjKY9rSaKJ9aSxXrQI2XPuw7nPB6fbQsEOm7Bgstsd0PLI8CY1j/vkJvWcQudjy+YvoEipOWUbDw5L57Nhbfze5iIXgcRpHfXdfE5qLbSq+mtXd9L5MJxnjeDqdxqGSyZwrHISeFIrOhsAKoCR2twtfllKsWtJLF8QC48/mP+CVH7eDjO0UyBHB7ADBq9BF3ZNhua7PBh1XevEccb4w/4F3Mjh59/9S2MU+u5pHCh+PNTUJ1qJMj4YtI9OufETKqhG1pT2E3QI6lpze8BfC3zext/OmbOttuI0Yx3TjOhgO6AwLIvxYjLrMBKC3uirZWc9OH1w+ViSFe57ZociIcd2WoaA/fU+eoQpMt8amp0RnkClXl3JZGZBPWwLEn8vSgjjdOD43e88/SClooai2TjwZde6To4ItCHm8O2FyDGeVrcUKS86+nu8jeoVpoPSE5q2ovei8/yy13EGDjSKTCOF/MfRDCJzGTe7D5V4rGbubgfNt0fJre4hyVjm4ynL9dGBPuI/+kAMcTFozpdnp05WCIGlrkstuhs5uh/46Rs+1yAL0Cyz5fsHgvZa39CHx6+dzs6r6qcthA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81c1d20-5565-4e4a-e27d-08daf264992a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 17:11:50.6253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qG9ngFahnOro/Cap1Q3TOUU0RkPLfZEI47ps9j8muz4QnE5eauEj3vCTT3SoBRp+IPedFndSIsZqj+Kos2mWsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090123
X-Proofpoint-GUID: -eugeok5bVqGUbg6cqa8uo3lFDlEz7OJ
X-Proofpoint-ORIG-GUID: -eugeok5bVqGUbg6cqa8uo3lFDlEz7OJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 9, 2023, at 10:38 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
>=20
>=20
>> On Jan 9, 2023, at 10:07, Chuck Lever III <chuck.lever@oracle.com> wrote=
:
>>=20
>>=20
>>=20
>>> On Jan 9, 2023, at 9:44 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>>>=20
>>>=20
>>>=20
>>>> On Jan 9, 2023, at 03:42, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
>>>>=20
>>>> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
>>>>> On 08/01/2023 18:09, Trond Myklebust wrote:
>>>>>> Hi Krzysztof,
>>>>>>=20
>>>>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@=
linaro.org> wrote:
>>>>>>>=20
>>>>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Lea=
rn why this is important at https://aka.ms/LearnAboutSenderIdentification]
>>>>>>>=20
>>>>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the defaul=
t
>>>>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer excep=
tion
>>>>>>>> when mounting NFS root on NFSv4 client:
>>>>>>>>=20
>>>>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: I=
nvalid
>>>>>>>> argument
>>>>>>>> [   26.199478] 8<--- cut here ---
>>>>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
>>>>>>>> virtual address 00000004
>>>>>>>> ...
>>>>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
>>>>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x17=
8/0x358
>>>>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x30=
4
>>>>>>>>=20
>>>>>>>> Full OOPS attached. Full log available here:
>>>>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
>>>>>>>>=20
>>>>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the com=
mit is
>>>>>>>> not the cause, but rather making it default caused the regression.
>>>>>>>>=20
>>>>>>>> I did not make the bisect yet which commit introduced it, if every
>>>>>>>> config includes NFS_V4_2_READ_PLUS.
>>>>>>>=20
>>>>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed =
to:
>>>>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
>>>>>>>=20
>>>>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
>>>>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
>>>>>>>=20
>>>>>>> NFS: Replace the READ_PLUS decoding code
>>>>>>>=20
>>>>>>> We now take a 2-step process that allows us to place data and hole
>>>>>>> segments directly at their final position in the xdr_stream without
>>>>>>> needing to do a bunch of redundant copies to expand holes. Due to t=
he
>>>>>>> variable lengths of each segment, the xdr metadata might cross page
>>>>>>> boundaries which I account for by setting a small scratch buffer so
>>>>>>> xdr_inline_decode() won't fail.
>>>>>>>=20
>>>>>>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>=20
>>>>>>> With a trace:
>>>>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
>>>>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: In=
valid
>>>>>>> argument
>>>>>>> [   25.986237] random: crng init done
>>>>>>> [   26.264564] 8<--- cut here ---
>>>>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
>>>>>>> virtual address 00000fe8
>>>>>>> ...
>>>>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
>>>>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
>>>>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
>>>>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x79=
0
>>>>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
>>>>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
>>>>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
>>>>>>>=20
>>>>>>=20
>>>>>> Is this test being run against a 6.2-rc2 server, or is it an older s=
erver platform? We know there were bugs in older server implementations, so=
 the question is whether this might be a problem with handling a bad/corrup=
t RPC reply from the server, or whether it is happening against code that i=
s supposed to have been fixed?
>>>>>=20
>>>>> I would say that buggy server should not cause NULL pointer dereferen=
ces
>>>>> on the client. Otherwise this is a perfect recipe for a rogue server =
in
>>>>> the network to start crashing clients and running exploits... Imagine=
 a
>>>>> compromised machine (through some other means) in a local company
>>>>> network running now a server with NFS share "HR salary data" or "HR
>>>>> planned layoffs", where unsuspected people in that network access it
>>>>> leading to exploit of NFS code on their side...
>>>>>=20
>>>>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
>>>>>=20
>>>>> Which points that it is not latest stable, so anyway I need to update=
.
>>>>=20
>>>> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
>>>> latest stable and I can reproduce the issue. Therefore:
>>>> 1. It is visible on two stable (one new, one old) kernels on the serve=
r,
>>>> 2. Buggy or rogue server should not cause NULL pointer on remote devic=
es...
>>>>=20
>>>=20
>>> The nfsd READ_PLUS code is borked up and until 6.2-rc1. I thought we ha=
d a server option to disable that code, but it seems as if that is not the =
case.
>>> Chuck + Anna, can we please send a stable patch to rip out that code al=
together from all the older versions? If we want to enable READ_PLUS by def=
ault on the client, then we cannot do so if the majority of NFSv4.2 servers=
 out there are running a borked implementation.
>>>=20
>>> I do agree that we cannot allow buggy
>>=20
>> or malicious, or non-Linux,
>>=20
>>=20
>>> servers to cause memory corruption in the client code, so I propose tha=
t we revert the Kconfig default setting change again until both the client =
code and the legacy servers have been fixed.
>>=20
>> I stand ready to receive and apply server-side fixes, as you suggested.
>>=20
>> However IMO it would be most responsible to go straight for a client cod=
e fix. The Kconfig setting is a red herring (as delicious as that might sou=
nd). Any thoughts about how difficult that fix might be?
>>=20
>=20
> A client fix is necessary, but not sufficient.

No argument from me. There is a problem on both sides.


> The older server READ_PLUS code is slower than ordinary read for several =
filesystems, since it relies upon the (often poor) performance of lseek(SEE=
K_HOLE). Leaving legacy servers as is, would therefore still cause regressi=
ons for clients that default to trying READ_PLUS, even if the code is fixed=
 to not Oops.

Backporting eeadcb757945 ("NFSD: Simplify READ_PLUS") to stable kernels wou=
ld address both concerns.


--
Chuck Lever



