Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3B6B685B
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Mar 2023 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCLQok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Mar 2023 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCLQoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Mar 2023 12:44:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCD01CAD2
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 09:44:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CCUgGV030665;
        Sun, 12 Mar 2023 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QUJiKM5cVF5GGN/pHu2rBusGxtodnYic9/MuDkVM1WQ=;
 b=jbFjGKn5V+JXZw3meoFfaAGsgk/QwbvPPHAtyJrmqzSXJpBVb/uE7e4V2P2MCyUgktdg
 hAU8+qJ0W1RaBxRSkZbGNVK93x5ZFuelIZWg0wittsMRXcNVuUBlVoBqBkyU/o3pRKO3
 95YQa+5V3qrVrJ8WgDtUCC4impGp2sL+3m6ktjqvGiLRYvwCVBlDfWvpN5K3Zrn2Uz/w
 vCjQsNN13Hb27nbEjNVV46BoLEGf41bbYJfSXcE+1aa8Hst5cX1zOwyIE6wMhdV1ViwI
 sF5nUGc2II64Uclhfk1BLqgbfYER/l/CyUcuBoHbqPcUx5tGCQbsXHOMtb7WNkD9cjWl Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8gjbac2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2023 16:44:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32CF22SZ007400;
        Sun, 12 Mar 2023 16:44:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3agjxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2023 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf3vZVUwfKpgu4ACylXsPX0/H52FCVbbbAV1ordjbmxN6pfdzvsJ0avXkbdAI8x7295oLlcxO3dBcFPdqZGz3LBdg8JV4POBxFvfbYR36MSkqvUACDLlY0xBYeW96Xgdh2Njr2vI2SEL+pYr+eMdhJcCmBT+lP8cg16ghItXaHJPYAJPFsnnxhRXNIYYCrAMA233KQt1CGO9e7GXQtgWWFB5sI11yX1tN5HKZJ943FMLycRXBudWf8quUnvlZ4pea5Kdv8FBQnQynQ7//luW7Gf4nWOQ2XZg6ZySJe1QAT8WC166l7fjG5ctti4FWAFxbCdbEpfKshgsLM1FaYfapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUJiKM5cVF5GGN/pHu2rBusGxtodnYic9/MuDkVM1WQ=;
 b=MuLSSlmGGVnxVmAdpvAKrOTEhCsN2KMGwYpbUrB5ELw9dgNyhc9RAHhoMNzPbuZ/SNvBiClvN9gSgTMkCRxcyLYllyC/ng/TWAmaRQmS55r+SUnlZWDGNp/GoiXKSujx2f7QwPfJjQXy10P8gkTeNk46CQiFp8MSSdo0fas5/CUBQv8ccQQu40FKMWFdGToVrAKfTXBAdwYKPqN9GTPp0LzLKUuiU2YSGl2DMACbxkCJtNJcrQ2pzcjk+DhKHDvo9NQ4JJf1P7sHHEPUwokGqdYddlvsRkwZdahp4386zMrNqXWUhUEoaZWLwuLz0W7chGlPMhhknIwq5PYs8ULmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUJiKM5cVF5GGN/pHu2rBusGxtodnYic9/MuDkVM1WQ=;
 b=Nv4kLqHeMRi1Loqh8hUz/va+g/9b5Pt37wRYKyRJIt6Q8/GtxLgGvVI4LRw6g0VrZT0U2e1tyGUibe80OANek6GersS9cbzlbc+x/uV9daQRXh+oTCIb2RaSBdI2e8uuu1qZ73FPFJKBEPDwBMzE/OlG+ZFb0k07Cpq6lviMEZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sun, 12 Mar
 2023 16:44:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%6]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 16:44:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Subject: Re: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Thread-Topic: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
Thread-Index: AQHZTcnxbdBJ4h9EiE6itgxSR0amOa7pIQIAgA4zagCAABPHgA==
Date:   Sun, 12 Mar 2023 16:44:20 +0000
Message-ID: <86A2B8E6-D4F4-4F5E-9E4A-3F833E8EC4D8@oracle.com>
References: <20230303121603.132103-1-jlayton@kernel.org>
 <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
 <CAOQ4uxhwN9Lgzn0_YB33Jfzy1idRene2=tBrr4s9T5PYefJm_Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhwN9Lgzn0_YB33Jfzy1idRene2=tBrr4s9T5PYefJm_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4536:EE_
x-ms-office365-filtering-correlation-id: 3900e06d-d50d-4d1c-0c0a-08db2319070e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGFpuMAH9gIUo2wNjV+dXDRm3WFPDx1/kvqstuDStUAmjeRUoWGKWyxKCAirXar4TnVSSlYc3z0WlGzHztDMqDrtkRr0mqbdkw5GnkAvANxp1IvxXnLSBGQGdMxaHZDoH626881us7ziKV8QQkaYGqQN75ZckZDQ9qlyF7r//3rjEfdoykluF68aaIlIGePcmbg6gd4DRlS2OZmcDpuDO9hiRejZUR603279LsWNnCZ8DXlauATxrkUFPj5fSDhKIzv+B+lnwI9LNbI1nTo+AX+/XUkctjAkr+wlYY5WXLbDYOFZdROe7BHFrkZ0omPcD6Tyq4ZRA3bGTYow3ZzrkwtVIJ/l6+G6JW5glpGhb6zUg+bX2eKVAQw6DFWhEHMGrdChW9r0/CvN3qiFqK7xo2sL0/IULt17t+qn3j2lMx2g5Ohbo+aenOLaQsHAECV4CLI/lpiEIZJT/F7eXSscGF2CD8HwB28UZbqyizJq1NbLW9q6BSJSTKURPxLRm0+EqQsfSmDPkdiApLUaX+jlcszIQpUWWtcq1qfjmn+fIUn01qkh5G+ayZjCo0Oi1e8v/os4eqyNeEhpy82oVEEnrQAoDgm06Km2Jv0eick66XhePrNSgz7mCExNBlQPQjOM7bVlVAhXpxTsiAuNI328Z67oF6o1q+T2JY+TLdaB2bxjTwnzro788FGvL/UXxCwRhR6Fjft8q5cCUhVVCtAPenh5qey/7qN5CqBq2YqpV/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(54906003)(26005)(6506007)(186003)(6512007)(53546011)(38070700005)(6486002)(8936002)(478600001)(5660300002)(71200400001)(36756003)(33656002)(2906002)(86362001)(8676002)(4326008)(6916009)(91956017)(83380400001)(66446008)(64756008)(66476007)(76116006)(66946007)(66556008)(2616005)(66899018)(316002)(122000001)(41300700001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGJGT0ozNWZndk54dEJqYlVHaTFHeHR5VVB2d0dHVnlJaFo0UWRuKzNnZTdZ?=
 =?utf-8?B?MHZ0akhmTVNpVC90UWl5a2FadFpQWlI1OHhpS3d0dHZJKzlGeTIvSHZnZUts?=
 =?utf-8?B?TUdaVGhRQnU3MzJDZHZzSHgwM1lPL3Q5M1RjTkx5c2U1MGlxWE8razBiRDd2?=
 =?utf-8?B?STFncC9kaE55WTFmdi9sdDRTOXdJdWZFenYrMGtTRXpLQjdCWm9WZjdEQ0h4?=
 =?utf-8?B?eW5QNXVmcDFDK2dscU9qdGFDcC9URXhKM3VEUzNUdERpeTdvYmNUdjFOSzRC?=
 =?utf-8?B?akNMVHZzc3drbWpranh1U2xoWVZzUWFpcmc3aVl1Zm80cVZXTXBjWHE2ZWhw?=
 =?utf-8?B?d2RPZUZISk5ucGNhaU14ZXRKMmJXbktpUjFmMUhtR05ycG4rYyt1ajYvdVV0?=
 =?utf-8?B?VCszVjZaRHJuMUdDbDc5dlVsb1pUVEtXZVllZ0ExV1hhNERFK1dxMEY5SlpT?=
 =?utf-8?B?OC91SnNXK0IrTkxtYkJxQ2dreXpjejJqbTN6NW91dHIxNUhUdHB4SXVha3Nu?=
 =?utf-8?B?MGxBUXplUFQxRkJ4cmlmblA0RksrVjN1MlJOOVJnQkJTWmtGM1NiL0FnQ3V3?=
 =?utf-8?B?TnBFZnFCUVM4bXJkS3MrKzAwUUtRR2cwME5LRjk5OHJxSHR6TytrZjk4aEl5?=
 =?utf-8?B?NUVsVGpXMy9rbFlscEFRNTdNc3VwVnhKQVVLREo2N1R0UjN6UWFvSjkwSEZu?=
 =?utf-8?B?Ykw5cFZzMEZRWGZ5WUFEcU41NlU5NytVdkxmckYyaEljZWlzcWs5UzcvR2tY?=
 =?utf-8?B?ZjBEOHFieWhtQWdPL0RzazV2WXMvc3dxL3BKbFJBTVd6MU1jMlkxb3dCcDdw?=
 =?utf-8?B?TGpXVURrMEh2SFVCT1RnQXdkSzJDQXdFeGFUQ3lvZmh5REtPWm92bVVVMFVr?=
 =?utf-8?B?UWRDM0pGMCtmRm9pRll1bDV2VllXb3MyVU5ZSkt3QVhOZzg3NWZFbGltSXpE?=
 =?utf-8?B?MUU2SWk5VTI3SXJhK0dMOTg1cThVaHZRQ25vOHVMMkRYbktoY1htQll1QVpB?=
 =?utf-8?B?VTZ2MXp3MTYrRllRRzRzV0ZobjJVdllsc0M2cDRaSU9YTzBhWS9BU0FIc2Za?=
 =?utf-8?B?U3ZCUHFzbDU4N2wvSDFpK0VUeUc1bjNZZFlRM252OEY1SkpNL3JJUHptdnNX?=
 =?utf-8?B?SXZrTWk0WFNnYlZXK2ZTaENIRytGSUlxb3Y4OG9WeGRXOUhQVVltMzAwUEJS?=
 =?utf-8?B?YjBFWEEzWW8vOWlKTGRYN0JvZlFXWGR4cWRoRmxwOG5LaHlIKzIxREFveGcw?=
 =?utf-8?B?TTk5UTE2OFJUMHpoQjUyU25kdUhTN3U5UXdKQ2syUXRpRFpIWVdDcHlYdEx5?=
 =?utf-8?B?VlYwb2hwalVRY05DK1R0Yjh3cWl6RU45UzljR01Mc0NmK1NHeXJkYmxLRHJO?=
 =?utf-8?B?Ukl5MzNML1lHemlqWllSY2l0TVJ2WmUrWUZNYkdkNUFDb2Fpb0VNRHViWUlJ?=
 =?utf-8?B?YnQ3SDdjQUtvTjJhVDI4YS9vM0ptOHNQd0pLNVFlMDM3OGt1N1JRWHY2VVU1?=
 =?utf-8?B?S2NRVDhXekc2alpQbEdieTJralBkZTF4U3R2bVdxRFlFQlM2aGVNZGUrMlc2?=
 =?utf-8?B?emptVFBJaXRTSFpyYU4yL1pJSnlQUnJwU2VQdnp3OUpqS2ZZaUhCQ09NUWxJ?=
 =?utf-8?B?UStqbjlwKy9wb3FSNk4ySTFOMEIzZ0t1b1ZMRXplK2JPdFJxZmEya3daRnRS?=
 =?utf-8?B?NFhwQlJvM0ZOb25iUXNzMlNqcVRRc0ZPZGxSVGJZbzlxcnFPVURKeWtNaE5k?=
 =?utf-8?B?TkxmajRQazFNVkhEeXJ5M1g0ODE4ejdqN0hDUGpGQjhvZmwxTlFEaFFxVjht?=
 =?utf-8?B?MVR6Snc2K1R4dlRyQlJaUnNUK2tMQ2taRGY1Q3U1MTlmc2FGY2ZWL2VMNHhr?=
 =?utf-8?B?bjEvNkE0bEJweHdKWkdLY0puMldzVzNHenh4cUFWTk5uQ3hiZktrOEpwR3ZH?=
 =?utf-8?B?cWZIQnFGL3dmbjVIcXQwZDYzMDl4Y1hPYmlKelpZcWhoaXNNR2xtMys4ZU1n?=
 =?utf-8?B?bUpsRzBrUWlhOGd3QTlKS0hKOVNSRDF5ZlRkOXFMNEpzbFlORDJqLzF6VUhw?=
 =?utf-8?B?L0oveWRzYWhmeVo0b0JQMTY3aElZc0wyRU1qb2FEa0xHMTNUNlhEN0pveitp?=
 =?utf-8?B?SnkvUTFZTXFWM3J4SjFwWERTczl5MzEzdEJOMlhlTEpFOFdHYmFYZXZzeXk4?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E10841C3F357E7429D1E89538C1BEDBD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 47Q25lc6I2FC9yHFhGc9VUf9Y7BW85PHyF2ch+TbHvnGdVVOhZdSjHDQICHBvzXmPBBHKjKVaoOPVdLX2GxTDuP8PLMkS5pfnUpsJe5sZXSc91YLMLzNlgnYYLpZ79Zv7acCM+oaAxN0QAx6DZaCZhG5wVx77Jcwl+9RF7gKbOdemV82u9Hr51rF3mbHR0vRhcRwmu1I3y2HEC3lS8IOtkB3l6OS+2j2lpJeaSVyVCY5nynvdhnvFZsLGVY3n1697kYz4QlNNnH+qUiHKM0xrYVGmP44cInDwM6VAE9PTTn/RA2Hr98HKe1cBv5jOcuasf7OoGJl0Om65UFaOhL28B4iX5IkmJ+6SK9CpNkNhAYkhmQg+iljzQjQtSRW7z0AWQ3ArCkMykGqh3QyBWPmSoB5OTLIISpM8fb7Mv5mHBEVNDHCEaCqGmX73nh1YTwgpZJp+tB0Mvn9KAfb0fUHyiduNCTL85WPxfk9ENB5AnwMIRfZxGSoC+PIlSD2SKH5HMMiJeKXXoNmVI4SSxA64Bo1wvOu8+/y5YuYKH/HiYVc6aD9I9YX4KZw7CPyizVWwXaphNXR6K/UQpS/GzRAMZYDg2cBG1UsQztlJs9n4EWJfVxKU+IQ4piNz81cY+TcL5n718rcwC0Hbs2z3B429IJkUqA353j6IogfsnTLvrESxwQuXs2QES4DtjLNuZyAyvOsFcO1ejOxC32joJs29lJerW8lpeTnPRqkFzSaP5T8za5FoUy97wyQBSMRIUc2YOUUjxGKP0IJaj6tqeYAigJReWwWsGI9XzAJY5d2q43ONh6LEHArg1uGUnImer8FxNxhApYPMFLu+6YjbyfIs+UWKfnVuus//u/SGdFuTWF5HC+oerJVzyH4oKiY3rGleH2mS0Jr36Pm7WQv3uJ+Tg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3900e06d-d50d-4d1c-0c0a-08db2319070e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 16:44:20.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jY8VdJizX8MF8MhjTcryXDblh3oH2nNAjmUxj08Cv92qoRkQ7B5Wfvl1PETskPgpr58w4pMoO+jvmYtT5sCTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_03,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=905 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303120145
X-Proofpoint-ORIG-GUID: 7JoorSbda-Qu8FPeGe3dT6wcfaWJAU59
X-Proofpoint-GUID: 7JoorSbda-Qu8FPeGe3dT6wcfaWJAU59
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWFyIDEyLCAyMDIzLCBhdCAxMTozMyBBTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE1hciAzLCAyMDIzIGF0IDQ6NTTi
gK9QTSBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+IA0KPj4+IE9uIE1hciAzLCAyMDIzLCBhdCA3OjE1IEFNLCBKZWZmIExheXRvbiA8
amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBJIHNlbnQgdGhlIGZpcnN0IHBh
dGNoIGluIHRoaXMgc2VyaWVzIHRoZSBvdGhlciBkYXksIGJ1dCBkaWRuJ3QgZ2V0IGFueQ0KPj4+
IHJlc3BvbnNlcy4NCj4+IA0KPj4gV2UnbGwgaGF2ZSB0byB3b3JrIG91dCB3aG8gd2lsbCB0YWtl
IHdoaWNoIHBhdGNoZXMgaW4gdGhpcyBzZXQuDQo+PiBPbmNlIGZ1bGx5IHJldmlld2VkLCBJIGNh
biB0YWtlIHRoZSBzZXQgaWYgdGhlIGNsaWVudCBtYWludGFpbmVycw0KPj4gc2VuZCBBY2tzIGZv
ciAyLTQgYW5kIDYtNy4NCj4+IA0KPj4gbmZzZC1uZXh0IGZvciB2Ni40IGlzIG5vdCB5ZXQgb3Bl
bi4gSSBjYW4gd29yayBvbiBzZXR0aW5nIHRoYXQgdXANCj4+IHRvZGF5Lg0KPj4gDQo+PiANCj4+
PiBTaW5jZSB0aGVuIEkndmUgaGFkIHRpbWUgdG8gZm9sbG93IHVwIG9uIHRoZSBjbGllbnQtc2lk
ZSBwYXJ0DQo+Pj4gb2YgdGhpcyBwcm9ibGVtLCB3aGljaCBldmVudHVhbGx5IGFsc28gcG9pbnRl
ZCBvdXQgeWV0IGFub3RoZXIgYnVnIG9uDQo+Pj4gdGhlIHNlcnZlciBzaWRlLiBUaGVyZSBhcmUg
YWxzbyBhIGNvdXBsZSBvZiBjbGVhbnVwIHBhdGNoZXMgaW4gaGVyZSB0b28sDQo+Pj4gYW5kIGEg
cGF0Y2ggdG8gYWRkIHNvbWUgdHJhY2Vwb2ludHMgdGhhdCBJIGZvdW5kIHVzZWZ1bCB3aGlsZSBk
aWFnbm9zaW5nDQo+Pj4gdGhpcy4NCj4+PiANCj4+PiBXaXRoIHRoaXMgc2V0IG9uIGJvdGggY2xp
ZW50IGFuZCBzZXJ2ZXIsIEknbSBub3cgYWJsZSB0byBydW4gWW9uZ2NoZW5nJ3MNCj4+PiB0ZXN0
IGZvciBhbiBob3VyIHN0cmFpZ2h0IHdpdGggbm8gc3R1Y2sgbG9ja3MuDQo+IA0KPiBNeSBuZnN0
ZXN0X2xvY2sgdGVzdCBvY2Nhc2lvbmFsbHkgZ2V0cyBpbnRvIGFuIGVuZGxlc3Mgd2FpdCBsb29w
IGZvciB0aGUgbG9jayBpbg0KPiBvbmUgb2YgdGhlIG9wdGVzdHMuDQo+IA0KPiBBRkFJSywgdGhp
cyBzdGFydGVkIGhhcHBlbmluZyBhZnRlciBJIHVwZ3JhZGVkIG15IGNsaWVudCBtYWNoaW5lIHRv
IHY1LjE1Ljg4Lg0KPiBEb2VzIHRoaXMgc2VlbSByZWxhdGVkIHRvIHRoZSBjbGllbnQgYnVnIGZp
eGVzIGluIHRoaXMgcGF0Y2ggc2V0Pw0KDQpJIHdpbGwgbGV0IEplZmYgdGFja2xlIHRoYXQgcXVl
c3Rpb24uIEhlIGRpZCBub3QgYWRkIGEgRml4ZXM6DQp0YWcsIHNvIGl0J3MgZGlmZmljdWx0IHRv
IHNheSBvZmYtaGFuZC4NCg0KDQo+IElmIHNvLCBpcyB0aGlzIGJ1ZyBhIHJlZ3Jlc3Npb24/DQoN
CklmIHlvdXIgdGVzdCBtaXNiZWhhdmlvciBpcyByZWxhdGVkIHRvIHRoZXNlIGZpeGVzLCB0aGVu
IHByb2JhYmx5DQp5ZXMuIEJ1dCB0aGlzIGlzIHRoZSBmaXJzdCBJJ3ZlIGhlYXJkIG9mIGEgbG9u
Z2VyLXRlcm0gcHJvYmxlbS4NCg0KDQo+IGFuZCB3aHkgYXJlIHRoZSBmaXhlcyBhaW1lZCBmb3Ig
djYuND8NCg0KQmVjYXVzZSB0aGVzZSBhcmUgdGVzdCBmYWlsdXJlcywgbm90IGZhaWx1cmVzIG9m
IG5vbi1hcnRpZmljaWFsDQp3b3JrbG9hZHMuIEFsc28gYmVjYXVzZSB3ZSBoYXZlbid0IGhlYXJk
IHJlcG9ydHMsIHBvdGVudGlhbCBvcg0Kb3RoZXJ3aXNlLCBvZiBhIHJlZ3Jlc3Npb24sIHVudGls
IG5vdy4NCg0KU2luY2UgdGhleSBhcmUgdGVzdCBmYWlsdXJlcyBvbmx5LCB0aGVyZSBkb2Vzbid0
IHNlZW0gdG8gYmUgYW4NCnVyZ2VuY3kgdG8gZ2V0IHRoZW0gaW50byA2LjMtcmMuIEkgcHJlZmVy
IHRvIGxldCB0aGVzZSBzaXQgaW4NCi1uZXh0IGZvciBhIGJpdCwgdGhlcmVmb3JlLiBBcyB3ZSBh
cmUgd2VsbCBhd2FyZSwgcGF0Y2hlcyB0aGF0DQpnbyBpbnRvIC1yYyBhcmUgcmF0aGVyIGFnZ3Jl
c3NpdmVseSBwdWxsZWQgaW50byBzdGFibGUsIGFuZCBJDQp3b3VsZCBsaWtlIHRvIGhhdmUgc29t
ZSBjb25maWRlbmNlIHRoYXQgdGhlc2UgZml4ZXMgZG8gbm90DQppbnRyb2R1Y2UgZnVydGhlciBw
cm9ibGVtcy4NCg0KWW91IGFyZSB3ZWxjb21lIHRvIHBldGl0aW9uIGZvciBmYXN0ZXIgaW50ZWdy
YXRpb24uIEl0IHdvdWxkDQpoZWxwIGlmIHlvdSBoYWQgYSBwb3NpdGl2ZSB0ZXN0IHJlc3VsdCB0
byBzaGFyZSB3aXRoIHVzLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
