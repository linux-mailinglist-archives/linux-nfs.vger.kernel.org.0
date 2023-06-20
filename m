Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD763736E1E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jun 2023 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjFTN7F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Jun 2023 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjFTN7E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Jun 2023 09:59:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83701BB
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jun 2023 06:59:00 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBepxJ013014;
        Tue, 20 Jun 2023 13:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Oxq8B61rVsGAyvIug1p/riOOzztp5odcXOkDKyXqg30=;
 b=Umixkf3Q++NKtfG1ojVIVY0JSHhEkO9xOdPdzqTrXuvjE2i/MlVq4OL7WgL6qNFhN7ji
 34wXBfAxCoY8S4iYnATc2GgcuuelHBihdvvX93MhaJi/hZW0nRy5Vnfo5xd/b2tnFFB3
 CXmcjADEx+sWDgwQ1ptyw4w9oaVkvpBgh1CQ5UEGtqvko64X8tVt3z1F5aL5kbSHYXPY
 qke7/jIH4FwP5jTusfkqLzq2nHgVUTI3fRnUyk5yAAJxXSUfhwLGivRxuFjInGSMfQnY
 lmJW8id+2+7BVN1rrgEQ/HAwsS9/VjOrpwCQXiCOoYBsk9im3v2lPS90GxLegT4PZufj 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbmuw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 13:58:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KDAZnO028849;
        Tue, 20 Jun 2023 13:58:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939amhsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 13:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBzHluxFddRGy3rdVW6WFmpBZTy8FXOsNukJAERoZ5zULVCwXb9q38VcLWWpoFc9mYv2OaVPLwqEN0rCb9RgPoVpCvXETUmgAebYsff9SrdhzAfbJ5l1K/VIBwDUh2uouJiH47cCWcRlksw5+hotY1JZ7z3s3fRpPjtbNGkG+I50ft1RDO1npRBLJD1RE8Y48FtbTVR5IKFER++1VPiCHLhiR3uMtfE3gF3T4QNykGQigKX395N6CDfykFGOXBI0jzRRsYHufJSqZZs46gaxNCadKKWYa9W4ad66DN6Wb0EY85uOgiO/T0fycCXAm37T4VwD6hWuPhohGCy4XHR37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxq8B61rVsGAyvIug1p/riOOzztp5odcXOkDKyXqg30=;
 b=HP/W8mQDKo1CYSngEeLs8k9e+GifdGeO0Vx+IoXfneQr+de9HZQyN3WuOmhHtGfZ65Bb/xuV4gauJjeUJjKS+7nSjyc/9qOOF1PTL8p1WfrhobrRyA7d0lga5S7JxD5FYMTXHKAu1uERcY016hfV4MtSpNQdQ6G0ohTEIcHKGlM643m3LukL8/L3bCcXT/NvaPv8Vn/TWB+8dr4MvEnanM+jgAa74aPCKtLoMKK2d4nNZK2DVoi9MDUN8vK33lJdyAB9YkRNYB4c1jx1TqZSqA0Xaf5eNskbSn+D0815bamEeOV+plhx2aargciY2PsHftsX1ELfNRPLZQZMmSA+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxq8B61rVsGAyvIug1p/riOOzztp5odcXOkDKyXqg30=;
 b=nXNFhVJUitm2a3/tDFuj3Uv8AonRl2KjPUwrH57zClIfgMby9XzBNBPIag/z58y+Ou8Wqvl1Pi6OAHGlkOVR0JdrXiYXDhnqNCG4nhIXoWM2yj97tcnH7RXaJazMTKKvZYiEKoxXUB1+PZ3sR2Xf8j4TvsSPI+VklnLcYzgDkv4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7208.namprd10.prod.outlook.com (2603:10b6:208:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 13:58:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:58:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.0 Linux client fails to return delegation
Thread-Topic: NFSv4.0 Linux client fails to return delegation
Thread-Index: AQHZos/yj80TeHCL8EaHc5sJIN1lPa+SgHAAgAAJhACAADETAIAA/fgA
Date:   Tue, 20 Jun 2023 13:58:49 +0000
Message-ID: <C1059D31-68A3-46E6-8304-91FA46EAF1BD@oracle.com>
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com>
 <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
 <CAN-5tyHR-Pev9Askv=CTVP7WtJ2L=r0Kzc7uaFer_5C6-OzMkA@mail.gmail.com>
In-Reply-To: <CAN-5tyHR-Pev9Askv=CTVP7WtJ2L=r0Kzc7uaFer_5C6-OzMkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7208:EE_
x-ms-office365-filtering-correlation-id: 1fdc6921-73c8-43bc-f0ce-08db71967928
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p13Xdts0fyh0pc4NWm1HdrNOdQM4gtA/8r7P7f6ewc1s4cthlT4HeM2i+IcgMhKu0ft+xHfxceYjbTVTHjbS1TqZa2wxl3SfehVeZpGebyEDzMzd+9LmujBuDt/JzJdWTQ2dqFKup5YxSz+Ttdbse4086+Dv0iX6r/usrTvm742ZDh5M53Eh1M8uo3Q+vMMBWDDGIDxhfp3eteUSJlv2bZLrbfEa8erd6ksLOlhrsUmq3g2QmLNnbeaL4e9wIWkOvgxxWDwW6j/odUqjTiS7ZV/dWS1SaW8sTkKnG+F0tu+EHgeNKoT3NuZWJJJY6rLuISgIKHdkNc4mAJs03bSvFayLwataHgHFT8XozG4bG1foWc/zw9b5yLic95y3dtQKxthiGri2HTyz9ejARpG6uf/77dQgo4SMCuuXGq/xyT450R/X86VkwpPFxXBolrbo92Otg8gCwU1qHmbMwcpU2XFu0hxrSuKIEXCqyAaQ6WZ6RuHISlsNKsFhWBnc2Z16d4y0etcOUke1HYcLPgfuVp/LBss6S47ff5crDbGYwSddetDMiCXhUdmtWEM7AST7Lp96MIzMOmY9NFErjWjjP4yTAfqltmwHH214PxbQ8xabxLA72cJSbP/6XAQBSGd/+IjI0TWUrOVUinbgfssXEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(478600001)(5660300002)(4326008)(6916009)(66556008)(66446008)(91956017)(76116006)(66946007)(26005)(66476007)(64756008)(2906002)(54906003)(41300700001)(316002)(53546011)(71200400001)(6486002)(8936002)(8676002)(6512007)(186003)(6506007)(2616005)(83380400001)(122000001)(38100700002)(36756003)(33656002)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2NDWDZQT2FRSjdXelVWL1FpNExvSkR1S0o4dDR4a3ptUmx0TU5HWG0wQ1F5?=
 =?utf-8?B?MlJCN1p6MWZIQ3kzY1FTQUZDaVV3Y0txY3YxWDgycmg1dlNGQjcxZGliLzlh?=
 =?utf-8?B?V3BnK003VDlEUVRIUjhmNU5oVzZCV1hRTGRyWDN5YzlLcDZpNnBja3NUYVdG?=
 =?utf-8?B?L3VLZS8zY2RLQmNyejdCVElwdzhmaFlIQUNyTkloMk1GaUdQYjdDWFBGWXor?=
 =?utf-8?B?M2N5dVhVa3h5TlllRHljaEp3dFl6d3RjWEpkdnhjSHhpcDM0Q0Vocy82S1lY?=
 =?utf-8?B?d3QvQVVSZStwZklDejR3TUlqK1VGYTN4QVhPTWxyRjQ4UHY2N3RZbHl6UUFB?=
 =?utf-8?B?VGplbmRCNDkrcmlscWV0UWc1SEc2ejFRUkhVM3lFTnlWbHA0VkgwaDcvWVRW?=
 =?utf-8?B?TzNDN2kvNzZBVXY5Um52Z3RtTStrM2ErOE1nNzRSbHFMM3JvNTBwWVhFL3p2?=
 =?utf-8?B?aDMxSTU5WmNwaVJoK05VbEFWL0VaSlNHVytrQktiM01kdWRYaUVUTG04QURn?=
 =?utf-8?B?Z1R3TFF3bmNxRXBOano0SXlCRGhGeW1SUXlhOFFxeHkwVUtVRkt3VUNzUFhH?=
 =?utf-8?B?MlFqa1U3dVpqbzVMbE11YTd3RHRqY2xod3VCeEtBSGRGcU1VUkMwWE9Yc3FG?=
 =?utf-8?B?YUJna1VBNG9aRzNMN1NKSzliem5MaDlhV0piaGpzbnBPQWs1YWRSbzNpU0dC?=
 =?utf-8?B?YkFlZTgxWWc3R2ZlWTA5VXpSdWdoRm9HUWNaZzVCaE83M2kwL3pnTUY3OEZl?=
 =?utf-8?B?Q1lueHpLUXlabHdieFFOTkJmWkVlNjlmMUZ4QTV3UnIvUXZldHZybXVMeXNM?=
 =?utf-8?B?UlZwRXphWTZEYnZnVVJiNjZ2dit4K090azNYdXpjSkdEMW5rMVN1dUFGM3c1?=
 =?utf-8?B?UHY2UkJacjNGMTVvYVV3YVdPbFZKQ2FYaEMwOENuMGJvOGlYNmhuYmF5Qldu?=
 =?utf-8?B?Y2NmM1BSK3M3ZFVvL3ZZRXBqZEpacGZxQlFvM052K3RzR0NyRnFuLzZobUt1?=
 =?utf-8?B?cHNMdlpSMWpMalVaS0dML09vMVV4YmJYUmlFdG9CMFpKRk5uQmx6S1ptdVVU?=
 =?utf-8?B?UEFqLzVvSlFqOXBDT3VzU0ZmTXVSTm0zY3NPeDFZMnN5enVFY3NtOGdMQVdF?=
 =?utf-8?B?NFlOb0M0dEE4NUp1RTdpVFRYZFhEQ25sVUo3eTJPVzZDSzVKMC9ZY29lM0JV?=
 =?utf-8?B?ZWx6NGppTXlHMDB3VUJ5WVZmZm9aclVwYWtObHFjSmoySktwR0JKRldtSWFR?=
 =?utf-8?B?N1hyMTF5TVlTM09LWHJLQkdSKzBiUjVFYWo3Z1d4MGVTSk12bkxUeWUyWFMw?=
 =?utf-8?B?R0VuUzgwSkpvKzlYaC9NaURReElpUkVPQUZidjBaTTdpdXhwaElaRTN4ZXJ2?=
 =?utf-8?B?cE42MU1Qemt4SzdVOS9QKzZVejZUUkh4aG9kVHFuVmlnblNIeXJldUFwL2w0?=
 =?utf-8?B?a0VsZmJkODRYVXEvWVRJMXhiV2xjWm9sL2lPZzV3d0N3QWsxUmdIMktVczhs?=
 =?utf-8?B?ZEZ5Y2tMbFlaZVpVeFNqVWNFQ1FKK1BPNFc0RlpqdThkNEJMSFFoU2NvcXNu?=
 =?utf-8?B?OVZxWHFOZmU5ZXdiMDBsalpzejhPcjd3OFVXT1E3ZTlpM1ZQVklWc1huMitr?=
 =?utf-8?B?aC9uTHZjS0xxRUZiK0xKSzFHU3dHR0FBdUx5eFEyUFduRFlqLzRWM0l6WDIx?=
 =?utf-8?B?MTJHdDFqdTJZbXNRQk1QcUd4LytOdm1IeWN2TWhxOXlDRUZ1dlVWZmxGRUkv?=
 =?utf-8?B?Umo2bG1YNXhDQ3BoL1ZsdlNVbkllL2tac0IzVFVmQk10dXFPMjdSMDZTczRW?=
 =?utf-8?B?L0JpeldyMDFVdzRxV1dYT010STVIV3poZStPYVlsYzhBSFNBQjAwakgzK241?=
 =?utf-8?B?K0RmL3NIMDlVZ1VwWVZLWWpyM2RWTXY5NHhSNGZCUVMyVE82K3VwTnVTLyth?=
 =?utf-8?B?QzYwRzVvQlJXamNSNG5KV2xwOGFvL3VpNk1tUWpVTVNLNDhWR05KdkVoeTlk?=
 =?utf-8?B?K0xIc21nRVh3eVlmL3hHU3YxV1V3UEhRajIyejIvTHBlYm1oOTRVYm9YbWVK?=
 =?utf-8?B?YjJmcnByY2V3TVpVekZaYmhSQ0l3b0xSdjdTRWNER1B4QkNSaXA0Z3JGV3FL?=
 =?utf-8?B?TEVsbEg1dWpkMUh0SmlTbDB5ZkxSU0pPdGdhZDhIQVR6WUZ1SXJwNlFycEQz?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A3CC3D677990549BE9CDD12C46BC86A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wFaqj9DSeIU7i7Bj1SCEqrTiCoXMO8VJevuo/BPuUyu9Zuv0Su4LZTfnpsJguYC5fsaLhX5oHFj6/zAFdbdvE4mB6ryk3I9MSddpCwjzOYc+/N4ToSvtWGC/q4f/rPfH7GLVdXaOwSN8Q9S9gI638yn6bm+VElBFSPkzoCzZxm4/bM13TfAyhDKoqk3d5r4FCFjaacMoUnb6zNyYw51gg/WP2JR3wRZIEpRUShUzTAGztYRQ+/6TgUgVXxNjEUrUSzcoxM3WB61H2c3IUqqFpRM1DOggvdyjUt4mb9Xlo7swp58ZAaajocaZfJpd1H8IQ2KcuTKueeVOKO/5dVxmzextN6GVR09TMxZWYDg7m/ADVTWbKakeTuoLJYSuGIkR4+5W3S/kEaMMeVuvDfvSKY6Dm5gLdaEIiptA95apbozIZb8T7TmxjIVlBriiQd5i24PXQiOUG7DehEv6trldRtzxWE4/OG71+Dhy2yM0LI/zbCC7lFatoVl5UHOywsoKQe+UjARwOJZ0oaVKeKq0+tnS6q2maQONXZ+ZPcO9fHQegH7Q0vH5Vjmjo4geNQzDUCfDowtQVtdMcVidvOXN98ke7FguvaGGgLaaea4zufIQlVd9+pFDyLY3PmUuH1TuY2L07luzylBoeNxFNN8rNK3cKYwP5Yww6AOoQdo3oub2B2uMxsmW7z8r5MKITmXuDKCp33AZYma8rOYOiIgUWj7HlDVIQSf5jG6VXgPGk8fCOZubXrl7YqrW7Wjt8S9tVdbbJsW/zsxPvVc5AnEV6RWSnRa+6JJCVMspnoPg8TP5C8p7kSEfF8cW4dglEZxi0M4FoKKdcpMa4auJk65pRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdc6921-73c8-43bc-f0ce-08db71967928
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 13:58:49.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P08XQkBdLgDFrWD228kQ5xRjUlKjmouQkM8e/4h+o1CbLVlDKVvQZvziEMzoEh//Sid4kUWGJIbJBJVpvrPZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200126
X-Proofpoint-ORIG-GUID: rzKR4K3SaXBlC9ylxq8t5IKRrHr39P28
X-Proofpoint-GUID: rzKR4K3SaXBlC9ylxq8t5IKRrHr39P28
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gSnVuIDE5LCAyMDIzLCBhdCA2OjQ5IFBNLCBPbGdhIEtvcm5pZXZza2FpYSA8YWds
b0B1bWljaC5lZHU+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKdW4gMTksIDIwMjMgYXQgNDowMuKA
r1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IA0KPj4gDQo+Pj4gT24gSnVuIDE5LCAyMDIzLCBhdCAzOjE5IFBNLCBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4+PiANCj4+PiBIaSBEYWksDQo+
Pj4gDQo+Pj4gT24gTW9uLCAyMDIzLTA2LTE5IGF0IDEwOjAyIC0wNzAwLCBkYWkubmdvQG9yYWNs
ZS5jb20gd3JvdGU6DQo+Pj4+IEhpIFRyb25kLA0KPj4+PiANCj4+Pj4gSSdtIHRlc3RpbmcgdGhl
IE5GUyBzZXJ2ZXIgd2l0aCB3cml0ZSBkZWxlZ2F0aW9uIHN1cHBvcnQgYW5kIHRoZQ0KPj4+PiBM
aW51eCBjbGllbnQNCj4+Pj4gdXNpbmcgTkZTdjQuMCBhbmQgcnVuIGludG8gYSBzaXR1YXRpb24g
dGhhdCBuZWVkcyB5b3VyIGFkdmlzZS4NCj4+Pj4gDQo+Pj4+IEluIHRoaXMgc2NlbmFyaW8sIHRo
ZSBORlMgc2VydmVyIGdyYW50cyB0aGUgd3JpdGUgZGVsZWdhdGlvbiB0byB0aGUNCj4+Pj4gY2xp
ZW50Lg0KPj4+PiBMYXRlciB3aGVuIHRoZSBjbGllbnQgcmV0dXJucyBkZWxlZ2F0aW9uIGl0IHNl
bmRzIHRoZSBjb21wb3VuZCBQVVRGSCwNCj4+Pj4gR0VUQVRUUg0KPj4+PiBhbmQgREVMRVJFVFVS
Ti4NCj4+Pj4gDQo+Pj4+IFdoZW4gdGhlIE5GUyBzZXJ2ZXIgc2VydmljZXMgdGhlIEdFVEFUVFIs
IGl0IGRldGVjdHMgdGhhdCB0aGVyZSBpcyBhDQo+Pj4+IHdyaXRlDQo+Pj4+IGRlbGVnYXRpb24g
b24gdGhpcyBmaWxlIGJ1dCBpdCBjYW4gbm90IGRldGVjdCB0aGF0IHRoaXMgR0VUQVRUUg0KPj4+
PiByZXF1ZXN0IHdhcw0KPj4+PiBzZW50IGZyb20gdGhlIHNhbWUgY2xpZW50IHRoYXQgb3ducyB0
aGUgd3JpdGUgZGVsZWdhdGlvbiAoZHVlIHRvIHRoZQ0KPj4+PiBuYXR1cmUNCj4+Pj4gb2YgTkZT
djQuMCBjb21wb3VuZCkuIEFzIHRoZSByZXN1bHQsIHRoZSBzZXJ2ZXIgc2VuZHMgQ0JfUkVDQUxM
IHRvDQo+Pj4+IHJlY2FsbA0KPj4+PiB0aGUgZGVsZWdhdGlvbiBhbmQgcmVwbGllcyBORlM0RVJS
X0RFTEFZIHRvIHRoZSBHRVRBVFRSIHJlcXVlc3QuDQo+Pj4+IA0KPj4+PiBXaGVuIHRoZSBjbGll
bnQgcmVjZWl2ZXMgdGhlIE5GUzRFUlJfREVMQVkgaXQgcmV0cmllcyB3aXRoIHRoZSBzYW1lDQo+
Pj4+IGNvbXBvdW5kDQo+Pj4+IFBVVEZILCBHRVRBVFRSLCBERUxFUkVUVVJOIGFuZCBzZXJ2ZXIg
YWdhaW4gcmVwbGllcyB0aGUNCj4+Pj4gTkZTNEVSUl9ERUxBWS4gVGhpcw0KPj4+PiBwcm9jZXNz
IHJlcGVhdHMgdW50aWwgdGhlIHJlY2FsbCB0aW1lcyBvdXQgYW5kIHRoZSBkZWxlZ2F0aW9uIGlz
DQo+Pj4+IHJldm9rZWQgYnkNCj4+Pj4gdGhlIHNlcnZlci4NCj4+Pj4gDQo+Pj4+IEkgbm90aWNl
ZCB0aGF0IHRoZSBjdXJyZW50IG9yZGVyIG9mIEdFVEFUVFIgYW5kIERFTEVHUkVUVVJOIHdhcyBk
b25lDQo+Pj4+IGJ5DQo+Pj4+IGNvbW1pdCBlMTQ0Y2JjYzI1MWYuIFRoZW4gbGF0ZXIgb24sIGNv
bW1pdCA4YWMyYjQyMjM4ZjUgd2FzIGFkZGVkIHRvDQo+Pj4+IGRyb3ANCj4+Pj4gdGhlIEdFVEFU
VFIgaWYgdGhlIHJlcXVlc3Qgd2FzIHJlamVjdGVkIHdpdGggRUFDQ0VTLg0KPj4+PiANCj4+Pj4g
RG8geW91IGhhdmUgYW55IGFkdmlzZSBvbiB3aGVyZSwgb24gc2VydmVyIG9yIGNsaWVudCwgdGhp
cyBpc3N1ZQ0KPj4+PiBzaG91bGQNCj4+Pj4gYmUgYWRkcmVzc2VkPw0KPj4+IA0KPj4+IFRoaXMg
d2FudHMgdG8gYmUgYWRkcmVzc2VkIGluIHRoZSBzZXJ2ZXIuIFRoZSBjbGllbnQgaGFzIGEgdmVy
eSBnb29kDQo+Pj4gcmVhc29uIGZvciB3YW50aW5nIHRvIHJldHJpZXZlIHRoZSBhdHRyaWJ1dGVz
IGJlZm9yZSByZXR1cm5pbmcgdGhlDQo+Pj4gZGVsZWdhdGlvbiBoZXJlOiBpdCBuZWVkcyB0byB1
cGRhdGUgdGhlIGNoYW5nZSBhdHRyaWJ1dGUgd2hpbGUgaXQgaXMNCj4+PiBzdGlsbCBob2xkaW5n
IHRoZSBkZWxlZ2F0aW9uIGluIG9yZGVyIHRvIGVuc3VyZSBjbG9zZS10by1vcGVuIGNhY2hlDQo+
Pj4gY29uc2lzdGVuY3kuDQo+Pj4gDQo+Pj4gU2luY2UgeW91IGRvIGhhdmUgYSBzdGF0ZWlkIGlu
IHRoZSBERUxFR1JFVFVSTiwgaXQgc2hvdWxkIGJlIHBvc3NpYmxlDQo+Pj4gdG8gZGV0ZXJtaW5l
IHRoYXQgdGhpcyBpcyBpbmRlZWQgdGhlIGNsaWVudCB0aGF0IGhvbGRzIHRoZSBkZWxlZ2F0aW9u
Lg0KPj4gDQo+PiBJIHRoaW5rIGl0IG5lZWRzIHRvIGJlIG1hZGUgY2xlYXIgaW4gYSBzcGVjaWZp
Y2F0aW9uIHRoYXQgdGhpcyBpcw0KPj4gdGhlIGludGVuZGVkIGFuZCBjb252ZW50aW9uYWwgc2Vy
dmVyIGltcGxlbWVudGF0aW9uIG5lZWRlZCBmb3Igc3VjaA0KPj4gYSBDT01QT1VORC4NCj4+IA0K
Pj4gUkZDIDc1MzAgU2VjdGlvbiAxNC4yIHNheXM6DQo+PiANCj4+PiBUaGUgc2VydmVyIHdpbGwg
cHJvY2VzcyB0aGUgQ09NUE9VTkQgcHJvY2VkdXJlIGJ5IGV2YWx1YXRpbmcgZWFjaCBvZg0KPj4+
IHRoZSBvcGVyYXRpb25zIHdpdGhpbiB0aGUgQ09NUE9VTkQgcHJvY2VkdXJlIGluIG9yZGVyLg0K
Pj4gDQo+PiAybmQgcGFyYWdyYXBoIG9mIFJGQyA3NTMwIFNlY3Rpb24gMTUuMi40IHNheXM6DQo+
PiANCj4+PiAgIFRoZSBDT01QT1VORCBwcm9jZWR1cmUgaXMgdXNlZCB0byBjb21iaW5lIGluZGl2
aWR1YWwgb3BlcmF0aW9ucyBpbnRvDQo+Pj4gYSBzaW5nbGUgUlBDIHJlcXVlc3QuIFRoZSBzZXJ2
ZXIgaW50ZXJwcmV0cyBlYWNoIG9mIHRoZSBvcGVyYXRpb25zDQo+Pj4gaW4gdHVybi4gSWYgYW4g
b3BlcmF0aW9uIGlzIGV4ZWN1dGVkIGJ5IHRoZSBzZXJ2ZXIgYW5kIHRoZSBzdGF0dXMgb2YNCj4+
PiB0aGF0IG9wZXJhdGlvbiBpcyBORlM0X09LLCB0aGVuIHRoZSBuZXh0IG9wZXJhdGlvbiBpbiB0
aGUgQ09NUE9VTkQNCj4+PiBwcm9jZWR1cmUgaXMgZXhlY3V0ZWQuIFRoZSBzZXJ2ZXIgY29udGlu
dWVzIHRoaXMgcHJvY2VzcyB1bnRpbCB0aGVyZQ0KPj4+IGFyZSBubyBtb3JlIG9wZXJhdGlvbnMg
dG8gYmUgZXhlY3V0ZWQgb3Igb25lIG9mIHRoZSBvcGVyYXRpb25zIGhhcyBhDQo+Pj4gc3RhdHVz
IHZhbHVlIG90aGVyIHRoYW4gTkZTNF9PSy4NCj4+IA0KPj4gT2J2aW91c2x5IGluIHRoaXMgY2Fz
ZSB0aGUgY2xpZW50IGhhcyBzZW50IGEgd2VsbC1mb3JtZWQgQ09NUE9VTkQsDQo+PiBidXQgaXQn
cyBub3Qgb25lIHRoZSBzZXJ2ZXIgY2FuIGV4ZWN1dGUgZ2l2ZW4gdGhlIG9yZGVyaW5nDQo+PiBj
b25zdHJhaW50IHNwZWxsZWQgb3V0IGFib3ZlLg0KPj4gDQo+PiBDYW4geW91IHJlZmVyIHVzIHRv
IGEgcGFydCBvZiBhbnkgUkZDIHRoYXQgc2F5cyBpdCdzIGFwcHJvcHJpYXRlDQo+PiB0byBsb29r
IGFoZWFkIGF0IHN1YnNlcXVlbnQgb3BlcmF0aW9ucyBpbiBhbiBORlN2NC4wIENPTVBPVU5EIHRv
DQo+PiBvYnRhaW4gYSBzdGF0ZSBvciBjbGllbnQgSUQ/IE90aGVyd2lzZSB0aGUgTGludXggY2xp
ZW50IHdpbGwgaGF2ZQ0KPj4gdGhlIHNhbWUgcHJvYmxlbSB3aXRoIGFueSBzZXJ2ZXIgaW1wbGVt
ZW50YXRpb24gdGhhdCBoYW5kbGVzDQo+PiBHRVRBVFRSIGNvbmZsaWN0cyBhcyBkZXNjcmliZWQg
aW4gUkZDIDc1MzAgU2VjdGlvbiAxNi43LjUuDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBp
cyB0b3RhbGx5IGlycmVsZXZhbnQgaGVyZSBidXQgZm9yIHRoZSBORlN2NC4yDQo+IENPUFkgbmZz
ZCBkb2VzIGxvb2sgYWhlYWQgaW50byB0aGUgZm9sbG93aW5nIG9wZXJhdGlvbnMgaW4gb3JkZXIg
dG8NCj4gZGV0ZXJtaW5lIGlmIGl0IHNob3VsZCBhbGxvdyBvbmUgb2YgdGhlIGZpbGVoYW5kbGUg
dGhhdCBpdCBjYW4ndA0KPiByZXNvbHZlIChpZSBiZWNhdXNlIGl0J3MgYSBzb3VyY2Ugc2VydmVy
IGZpbGVoYW5kbGUpIHdoaWNoIGl0IHdvdWxkDQo+IG5vcm1hbGx5IHJldHVybiBFUlJfU1RBTEUg
aWYgaXQgd2VyZSBhbnkgb3RoZXIgY29tcG91bmQuIEJ1dCBvZiBjb3Vyc2UNCj4gb25lIGNhbiBh
cmd1ZSB0aGF0IHRoZSBzcGVjIHNwZWNpZmljYWxseSBzYXlzIHRoYXQgc2VydmVyIG5lZWRzIHRv
DQo+IGxvb2sgYWhlYWQuDQoNCkV4YWN0bHkgbXkgcG9pbnQ6IElNTyB0aGUgY2xpZW50IGNhbid0
IHJlbHkgb24gdGhlIHNlcnZlciBiZWhhdmluZw0KdGhhdCB3YXkgdW5sZXNzIHRoZSBzcGVjIGlu
ZGljYXRlcyB0aGUgc2VydmVyIG11c3QgZG8gdGhhdC4gVGhhdCdzDQppbnRlcm9wZXJhYmlsaXR5
IDEwMS4NCg0KDQo+PiBCYXNlZCBvbiB0aGlzIGxhbmd1YWdlIEkgZG9uJ3QgYmVsaWV2ZSBORlN2
NC4wIGNsaWVudHMgY2FuIHJlbHkgb24NCj4+IHNlcnZlciBpbXBsZW1lbnRhdGlvbnMgdG8gbG9v
ayBhaGVhZCBmb3IgY2xpZW50IElEIGluZm9ybWF0aW9uLiBJbg0KPj4gbXkgdmlldyB0aGUgY2xp
ZW50IG91Z2h0IHRvIHByb3ZpZGUgYSBjbGllbnQgSUQgYnkgcGxhY2luZyBhIFJFTkVXDQo+PiBi
ZWZvcmUgdGhlIEdFVEFUVFIuIEV2ZW4gaW4gdGhhdCBjYXNlLCB0aGUgc2VydmVyIGltcGxlbWVu
dGF0aW9uDQo+PiBtaWdodCBub3QgYmUgYXdhcmUgdGhhdCBpdCBuZWVkcyB0byBzYXZlIHRoZSBj
bGllbnQgSUQgZnJvbSB0aGUNCj4+IFJFTkVXIG9wZXJhdGlvbi4NCj4+IA0KPj4gDQo+PiAtLQ0K
Pj4gQ2h1Y2sgTGV2ZXINCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
