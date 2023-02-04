Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1DB68AB03
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Feb 2023 16:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjBDPtp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Feb 2023 10:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBDPto (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Feb 2023 10:49:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9430290
        for <linux-nfs@vger.kernel.org>; Sat,  4 Feb 2023 07:49:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3145m8jL001530;
        Sat, 4 Feb 2023 15:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0Cfl2Z/Usn77+6vDBwOf6YCBT2oAs2+GWICruQHx3bY=;
 b=bmNS+WLDgijVW+FOpoV5DLDROXZydoPbOUi9/a3FiG/VtEGOvkwwDF6Byfn+3jlupr5g
 KCH6Z7r9S+KiqM0SAxoSJTFqDbUf8SV2Gtpg5IKwiwYAJWy7GnCJeCW8fnrZ27vAvTxN
 KmqvstVXIjn4Ej8hQVEjYAF1o1lssyeOMyI9L0JTEJvRsHoiikZphkTwdCmsQQuab0d0
 0USXz8CQCr55JBbNO1ghdO8Te+vQ/DCg1AIWuHhQZ6Ps08lwQzvWOB9/p9733DcCybCI
 jxuDbFD195Qd7sZ45N3PMRbr5LFAK+CjEjLim+nrfUvJuIFxyV1H28svACmRML+ncxwN EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8a0grj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Feb 2023 15:49:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 314BIQga020920;
        Sat, 4 Feb 2023 15:49:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt2ef5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Feb 2023 15:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXVp4L382mbnl8/OcapDYc3BFoY+iLeG7y9kW4uhTMblEwDnvqCGQj3Rsnp9svFHsX9H5XOywAsDvL3ayfc8CLHM+ABBPvsinIsSEfcz3vfqJpEJSa2F4ODphcOudeRaIb27Px2t3eEF6lZUWHG8EN9DLBP+1D5hefsaclWczcYCFGKd4u1P94HxBMXCednQe4JLO92jNVOlgDALAh1bN3ohSTuRKt+3BjdkWlnthEmDiZ8ZBHO7BUKVKwUga0RwyFjPIMpejuY3C+XPlkiIfmDaTwKhYcs31eTnB/s0OT/i5KTBG/U+IdsmZrlHzUJm12Gm7+0sToz34tgyMYSegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cfl2Z/Usn77+6vDBwOf6YCBT2oAs2+GWICruQHx3bY=;
 b=QQ/fmIpVbbkj1V41Db8NtEUVlSSqPqiRyrxsjk4A6lbfet7DCYi9B2Y6t8hgMUpFiL9aYV6bHdm/yERJpDtjdE7cbCUtWafXZkw4TD96d/nw4NDZudQlBZhgViT7RrBrchXJXCF0V4kmFJomkNIcWLWCx5NlxJP7/GaibA463gEInbP2S+D1U4DFTRzhHHHP6xgtn2deXjfn2+6y2y2JIGkZrqa/SR3uuIhz/k+BB5xpKhLI27/2qTrxwGuuCbLn/5Jc3WRYjJS/KIm0coDlUoq4H5R4l+2v6+e9ZOkspmx/SLzN6RMN1l2Obxwe+HaIF3Yy5/xjbq0GA5tg6hEWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cfl2Z/Usn77+6vDBwOf6YCBT2oAs2+GWICruQHx3bY=;
 b=0CzCsP750qyqI4CMK5VGJQTCHJcpgGuXdKdC2mbgGKCzeL0qQuG7POpmYYKCpOIsbwcJs1RxeRSqYXp1WrGGkqwRWFpQjAvLHfaT/+vHQ0/uhoW7Lm/M7NViT8eSlhBh37w8Gm3m5xZQec+7mnPlSLrpIom2ZLa9wfub3EPUipw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.9; Sat, 4 Feb
 2023 15:49:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%4]) with mapi id 15.20.6086.011; Sat, 4 Feb 2023
 15:49:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        =?utf-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
Subject: Re: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Thread-Topic: [PATCH] nfsd: fix courtesy client with deny mode handling in
 nfs4_upgrade_open
Thread-Index: AQHZN/vzN9JTANqrsUSg42Efwd8M+a6+8JeA
Date:   Sat, 4 Feb 2023 15:49:36 +0000
Message-ID: <C2BCC8BF-0E30-4548-A743-EF3A62DC4BDB@oracle.com>
References: <20230203181834.58634-1-jlayton@kernel.org>
In-Reply-To: <20230203181834.58634-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6733:EE_
x-ms-office365-filtering-correlation-id: 2ddead41-2505-416c-e5c7-08db06c76ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0cs8HtEKuttt6lNgnC4VYjp2OgPkxoC4vPdRzdLrVhWr4aIxVvMAhWwYQbAR0VRIGAzaeQc9TvDo1nYEIsC+zwDXC/Y6VZJFQ22WJW4uc85zi2k2V6YcHzgf5OUIaoNlWtdJBEaWoLcwW7exrScdkgPphsVi/bnJ40V2b+uBfoHzzHwhr3gBQCyXudpDv4yTHUozZxv9E/A4n7xkG61GSJNxgXNutIKEIvQsmodM0Wph7eVYAuZWvlzczxJwNVtHQ5ypdK9iK9ei8iUViNWLYzxrYmz5oHsUXMwIDbNDadkA0jDcd4GF85sy6bODPoJmfgVYbHzFViYZBAd5fqBhM+KqWTfUv70bkPhHXhTu+7tUlXVRVMhG/IbPMlLmUJ6C32FuS6gQmanHhkuMayffHYzUN57DPKYh/mdWbzysgdWtWIH/q5nDBi6PvcEio7X0G6+P5qUdbxLjuatyQUEJgBNh2992utOsDiqalZe0Rl2j3Feq4uCU9CC4un/wpFnee4xJHynmiFU4mA2vySrgK0h8An+aEGEp+eRnJYA5LxyDxmWZBaiv0vkUeTE5IdGMjt2CW/a3Kh9K5ip+lwiq4tWp79vRtzVJQOyNLhv7sJCuRuWxhYneLtW44euf7PeZtu5osx9VD5qN3Cq7MPQANBnd7zRJBIG/IUftJfA6SAhILDm0oisFm2t3+rKj5IYoAePv4bcy6zKPHTI0NubiPiSW4ZiXfmYFDL0tyu9EHbU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(66899018)(2906002)(478600001)(91956017)(36756003)(33656002)(6512007)(26005)(186003)(5660300002)(53546011)(86362001)(71200400001)(38070700005)(8936002)(2616005)(41300700001)(6506007)(6486002)(66556008)(64756008)(66446008)(66476007)(66946007)(8676002)(83380400001)(38100700002)(76116006)(4326008)(316002)(122000001)(54906003)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUI4eCtlVnNUK29qeE9vMmZzcnZuQ2pleUV3R2hBWWxCVWNyZnNhMGUyNzlL?=
 =?utf-8?B?clJGTG1kbWpMWS9DZXNIVnpqWENORGhGV01Ic0NOL1U2UTV0bjZRMWFObTRW?=
 =?utf-8?B?NkJCYmJMWndQbUpaaEJpcTdlWWdKUmd2TzhCWTVOdG5mRkduOEJ0dEVPZnF0?=
 =?utf-8?B?WkEwc210MTFFcGtwM3E4ZWNhY0hNUy81M3pFaHJNdE5GVURwTGpyNm5UTU5G?=
 =?utf-8?B?Ymw3RTVnbWYvVU90K2NNQkZHek1HbjI4V29iOW11TWd5UmVYRmJjaCtzblJJ?=
 =?utf-8?B?V0MyeXp2b1Vra29mMlJTZUlxdUZvcm8wRHJDcU5DRVEzeTBHeFhISVFxbytj?=
 =?utf-8?B?QkdHQlFVTEhsd2VSN3g3MEtFbkRGbHZoV1Fjc3oraThYTzNXWkdrYy9SZnlu?=
 =?utf-8?B?UVk2a1ZPZmVZTXBTL1h0UjFjeklodmxIMG9CcHVOc0lzaEpURURaaTAvVDlp?=
 =?utf-8?B?RUl0ZFlkUVM3R2xhR0FTWHM1cmxnMTNTTVNkd2FXbUoyMUFuZm9xSnJBQnZ6?=
 =?utf-8?B?K0srcEVXMExsZDN3T2JmR0UrMDdtL1lkd1MzMmI1Mks1UGJqeVlra1BFQm1a?=
 =?utf-8?B?RkpVL0Z5ZjUxSEhOdkY4VFJzd2tyRUMvZWF5ZnZoYmxDemFHbm5nK1FtUjRq?=
 =?utf-8?B?QnlWUDZXOUFZMGtLdjZsTytSVVdoSUxDdkV1NUNTeUhOTE8yK2FpMmNNajI1?=
 =?utf-8?B?WGt4RGoxV2lKL0NGczFIOTBhQXVhc2Q2alhRMFcybFBPUkI2Y1lxNzFjdTBX?=
 =?utf-8?B?QnBiS0FQbHkzVjU0UHRZWWF6VlBqOTZ6S2tOY0xiYi9CWFczdk94cWQ5VXZB?=
 =?utf-8?B?QTliak9qb0tmK3UzN2thS1lJd0JVcGxnaE4xY2pIQjU2VEl5b1lweTU1dVNB?=
 =?utf-8?B?Qm8yK2E0Q2tQUlRHdXI3OXRoMnlKcXQwNmVFMVJKbG80ZEp3Mi9uWmJLYTlw?=
 =?utf-8?B?VHByMmwwSWVhY0sxSFFYclRxVFUzN2dxSzlnbmErVEIxWUFOK3J5MW11YXFD?=
 =?utf-8?B?VGFXUUszR1FCUDkvVGlMamMydzdoUTZISWV3ZXNtQW1ZN210T0R5V3dkNlQx?=
 =?utf-8?B?YUpqdzBXSWRnSG8waEVxR2dhU1hIL1FlRWdIS2themFDV1dtaHB6MVdqWHIz?=
 =?utf-8?B?WHdDdlorS1R2amU4TDc0N01aUFh4Y0VGeitrSnVxakVIM1JmSWI3cStqWldQ?=
 =?utf-8?B?MWc5OCttZGRQRkZ2YmZVa0NQbzNpanY0aTF5ZjRvUDhXeEV5R3I2eG90WXNi?=
 =?utf-8?B?UnZTRHNTREVpcDltV2QyNWdPbHFNSlEvWTdES2YyQ1VHMTlVZkk5RHBmL3g5?=
 =?utf-8?B?YWk4eTl6QmJDbjhKZENqUm5TSWtrVjJOQ0VWaGEyVWpDOC80bzM2UDcrNE9F?=
 =?utf-8?B?bEtqLzB2RXZmcFY0TXprdnhTcHB0amNhZTNHNDBCK2Frd1NVM3VDV0Y2bnR0?=
 =?utf-8?B?MTYyY2lZbWdCbjdzRE1uMjRmN3FJM1luRnZubHBGMHVoMjgxK2hsQmtpVzNG?=
 =?utf-8?B?ekphOTJsaGtBYksxZnRNbXUxdllhVzFZdWVpUHpVZk5pZEQ0Mlk5aFRQcDRU?=
 =?utf-8?B?NjhBejF6c0IrV0txUnBkL2pOQUZtcUxqZ2tKUXZjNGJwS3pmYnpVTmUxK0J6?=
 =?utf-8?B?UWNNTW1JZ3RpTk1TYWZXaTkzcFBCdmNDSElhQUtiSndGaklxdDRMNS9vTlp0?=
 =?utf-8?B?UFZQOHhkY25zSk5sQ2NoZzJoaTVETS9BVnJ1Q002ZjEwRUdjKzJzWDhLWUFo?=
 =?utf-8?B?QXV2SXAyQ1hGaVJJbzlWVnFkSmI0RHd1NGdNQXFUUDhDMnJvYW1oSU1QNkRn?=
 =?utf-8?B?dnJvTkZST2w5UzY3Mkp5Y2tRQW9ZOTZZL2d3WWJ1TldHTnRsYXUzR0RXK0or?=
 =?utf-8?B?MjBlVHAvQWV0ZUc3UUtSeitFaXhwMkNmYTdXdzBGbWVYekh1Y2ppSk0xOXMz?=
 =?utf-8?B?NzM1SGRKSmxleXRzNUt4Z20vYitCMUJOT3F2MzF5dTlzTWtTY2JwTkIrT2JU?=
 =?utf-8?B?OHpXS1VIelpLZ2xJSmVuNnkvM0drUHpZU1NreFJBOThZNUhOVTIyckdGVUJF?=
 =?utf-8?B?cE1PMkMzdXJ1bXRPeEVTRVVvWmhtN3A1WFFDOU5jM3RlOG1IMEd5TDExZ2lo?=
 =?utf-8?B?TG4veEFRcjgwWlZhdlRhSVFXdHZEdFJxT2Z6MkgrWlpxVExjdnpLUjZWSUFT?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27C3327406277C4FA429B4AAC5207CA8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 81ajdL+CNlP0cXqAw0uxO8mcP5CQWppXEfousDIqMauzqgLi7CNTHGvQBqEQQ8ydHULa51+M8NrNLnAJ4cPvlDI/nHgG1sCZPjQvqNFasP2gBxrQp1bpwi7jJVrXdyP4daPCBA1Kp2N30mfVNXUHVVjuBQNBrIfuDFzw+nw1kh/zuzH3h1IoD4peYwtzzZRB4atutgIkUqJ/KvII/ZMsdrEhYHCO7Y4ibUQA44M3zauocrZSjVH6GXRPSE4IIfNgYiwE2IhbMuUXaAXvogncYKEz7f56xtu2RjzsFLJwsgDZp3mQmkwvXvX0T44RWCIQv6p6HBCnmrLAoBuFXu0DG4edVcU/OMMzMPb9voux8MQ5JaX/++yWOgwjHkyjR3i1EXs7RfUSlOum+PhDQQVOVb4KJFcNQ21gBkZEftu+5ujnkqNKeEM1lnEH1UuzUxXyYPSTBfXIDgAcTeuV6UOyQ1Bme1ooh4SWD98J490DOXtPGCG2J3ZJ+NkS1R1DFk/E04u0oyBxwvIE1xVV9gYuK9omS+N4kNZv0AtsNHKDkbW9aVL5C8mJEY1j5LOKj3/HXlf8GPq8O4GsR32bS5nZ4aeWKNJTxJGZ9nqMUUUkvO6ZOXz0+Zy1pv3KDS0ZIXXXjl5cupaVUkdcVfa7ZhvNma1etcvBfe2kdwMO5aXolopZSf+fuWtZn1MJsjpMuq7d787R3Qbfm3cdS7UTSVK5MiyGfFLxGQW5vibfAkaWnRYXFyfpoYXzzRTgfGAqWsDcCseS5PJpGkKVbIeOtlUomPz93I4NDOR8Jg34bOaa8P88uHC1eGOjqTSLjWOZYdx/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddead41-2505-416c-e5c7-08db06c76ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2023 15:49:36.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKiN7ZDHON3qRWrRYhVcmc71RhPhfR2vhp4rYzlwUh2kv++xjy+qls9wCVxgwtQyHDYQ8VbNWW5jbAJ25RXtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-04_07,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302040140
X-Proofpoint-ORIG-GUID: 8m6ZQm2GPRtGtgHDfsdWYGAu9Yfs2jeN
X-Proofpoint-GUID: 8m6ZQm2GPRtGtgHDfsdWYGAu9Yfs2jeN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gRmViIDMsIDIwMjMsIGF0IDE6MTggUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gVGhlIG5lc3RlZCBpZiBzdGF0ZW1lbnRzIGhlcmUgbWFr
ZSBubyBzZW5zZSwgYXMgeW91IGNhbiBuZXZlciByZWFjaA0KPiAiZWxzZSIgYnJhbmNoIGluIHRo
ZSBuZXN0ZWQgc3RhdGVtZW50LiBGaXggdGhlIGVycm9yIGhhbmRsaW5nIGZvcg0KPiB3aGVuIHRo
ZXJlIGlzIGEgY291cnRlc3kgY2xpZW50IHRoYXQgaG9sZHMgYSBjb25mbGljdGluZyBkZW55IG1v
ZGUuDQo+IA0KPiBGaXhlczogM2Q2OTQyNzE1MTgwNiAoTkZTRDogYWRkIHN1cHBvcnQgZm9yIHNo
YXJlIHJlc2VydmF0aW9uIGNvbmZsaWN0IHRvIGNvdXJ0ZW91cyBzZXJ2ZXIpDQo+IFJlcG9ydGVk
LWJ5OiDlvLXmmbroq7ogPGNjODVub2RAZ21haWwuY29tPg0KPiBDYzogRGFpIE5nbyA8ZGFpLm5n
b0BvcmFjbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJu
ZWwub3JnPg0KDQpKZWZmLCBwZXJmZWN0by4gVGhhbmsgeW91IQ0KDQpEYWksIHJlcGx5LWFsbCB3
aXRoIHlvdXIgUmV2aWV3ZWQtYnkgYW5kIG15IHRvb2xpbmcgd2lsbA0KcGljayB0aGF0IHVwIGF1
dG9tYXRpY2FsbHkgd2hlbiBJIGFwcGx5IHRoaXMgdG8gdGhlIG5mc2QNCnRyZWUuIFRoYW5rcyEN
Cg0KQW55b25lIGVsc2UgaXMgYWxzbyB3ZWxjb21lIHRvIHNlbmQgYSBSLWIgb3IgVC1iLg0KDQoN
Cj4gLS0tDQo+IGZzL25mc2QvbmZzNHN0YXRlLmMgfCAyMSArKysrKysrKysrKy0tLS0tLS0tLS0N
Cj4gMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2ZzL25mc2QvbmZzNHN0YXRlLmMgYi9mcy9uZnNkL25mczRzdGF0ZS5j
DQo+IGluZGV4IGMzOWU0Mzc0MmRkNi4uYWYyMmRmZGM2ZmNjIDEwMDY0NA0KPiAtLS0gYS9mcy9u
ZnNkL25mczRzdGF0ZS5jDQo+ICsrKyBiL2ZzL25mc2QvbmZzNHN0YXRlLmMNCj4gQEAgLTUyODIs
MTYgKzUyODIsMTcgQEAgbmZzNF91cGdyYWRlX29wZW4oc3RydWN0IHN2Y19ycXN0ICpycXN0cCwg
c3RydWN0IG5mczRfZmlsZSAqZnAsDQo+IAkvKiB0ZXN0IGFuZCBzZXQgZGVueSBtb2RlICovDQo+
IAlzcGluX2xvY2soJmZwLT5maV9sb2NrKTsNCj4gCXN0YXR1cyA9IG5mczRfZmlsZV9jaGVja19k
ZW55KGZwLCBvcGVuLT5vcF9zaGFyZV9kZW55KTsNCj4gLQlpZiAoc3RhdHVzID09IG5mc19vaykg
ew0KPiAtCQlpZiAoc3RhdHVzICE9IG5mc2Vycl9zaGFyZV9kZW5pZWQpIHsNCj4gLQkJCXNldF9k
ZW55KG9wZW4tPm9wX3NoYXJlX2RlbnksIHN0cCk7DQo+IC0JCQlmcC0+Zmlfc2hhcmVfZGVueSB8
PQ0KPiAtCQkJCShvcGVuLT5vcF9zaGFyZV9kZW55ICYgTkZTNF9TSEFSRV9ERU5ZX0JPVEgpOw0K
PiAtCQl9IGVsc2Ugew0KPiAtCQkJaWYgKG5mczRfcmVzb2x2ZV9kZW55X2NvbmZsaWN0c19sb2Nr
ZWQoZnAsIGZhbHNlLA0KPiAtCQkJCQlzdHAsIG9wZW4tPm9wX3NoYXJlX2RlbnksIGZhbHNlKSkN
Cj4gLQkJCQlzdGF0dXMgPSBuZnNlcnJfanVrZWJveDsNCj4gLQkJfQ0KPiArCXN3aXRjaCAoc3Rh
dHVzKSB7DQo+ICsJY2FzZSBuZnNfb2s6DQo+ICsJCXNldF9kZW55KG9wZW4tPm9wX3NoYXJlX2Rl
bnksIHN0cCk7DQo+ICsJCWZwLT5maV9zaGFyZV9kZW55IHw9DQo+ICsJCQkob3Blbi0+b3Bfc2hh
cmVfZGVueSAmIE5GUzRfU0hBUkVfREVOWV9CT1RIKTsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBu
ZnNlcnJfc2hhcmVfZGVuaWVkOg0KPiArCQlpZiAobmZzNF9yZXNvbHZlX2RlbnlfY29uZmxpY3Rz
X2xvY2tlZChmcCwgZmFsc2UsDQo+ICsJCQkJc3RwLCBvcGVuLT5vcF9zaGFyZV9kZW55LCBmYWxz
ZSkpDQo+ICsJCQlzdGF0dXMgPSBuZnNlcnJfanVrZWJveDsNCj4gKwkJYnJlYWs7DQo+IAl9DQo+
IAlzcGluX3VubG9jaygmZnAtPmZpX2xvY2spOw0KPiANCj4gLS0gDQo+IDIuMzkuMQ0KPiANCg0K
LS0NCkNodWNrIExldmVyDQoNCg0KDQo=
