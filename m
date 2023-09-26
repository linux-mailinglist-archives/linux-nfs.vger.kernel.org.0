Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5761F7AF7AE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjI0B0Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjI0BYQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 21:24:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D40421D
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 15:55:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLTVlZ010282;
        Tue, 26 Sep 2023 22:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HFy+wSPBvFvdZ2gtSY3G31NTxidzoa/eLUijaIoxp6g=;
 b=lJpKBaUfuVl/RQL8AvpbksQnvHYl/BX6522OJl7Obk0WWmG+HjQObfTnpRe6EgPaD/PK
 4SSvXzyeCK4FE8Pt2Fdu6o9UZ54Iuh7eMvIZTLlR62pfvMM63uAfqTEUGq/2qUK+KKWj
 Ig3qBWzZP/0bFrtnmlw3k5gRqUBNCMF4FfEAQ8Np8IJvE9I41Yf7g9RD4mp1eSrOlvUN
 i9DrZg9IQ/n8Qro3RnwX0rfJzgqK26GYv5NiETZU5TrAoEqz4tzxUU/smI14M0+YmT8b
 88NocjRF3+nTg9xjeVPsceuMzs6+7WgpMtaHryWgmljtIibPy/t+Y6w+gDX4W/inmkv0 Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2869w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 22:55:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QKbgNg039348;
        Tue, 26 Sep 2023 22:55:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfd062e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 22:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqxB0dEHZxzE6wls0iS0VvtJIt/c+Bkluojlt1VRH1pLBdm/uNpaf1nRj8uKs9u3Qnq/+sg+kwyZlhCCF81nKQe2sOTnerVGjrGFs9Iof+O2jEaiiaDMhAcJV4WgEgkYLcdJ/1b7f+y7TRlV5cEjRNzMa9dSOyscZ91+nRxK6K6sY7EthfVxgMO13rPEtpb1TMYiccEOD/Q20Tm7v0rqVOWhM7XFqGXZL4cjOwZrHtbI3pYHNSmasbDCKcKym3Gw6rE8x8iW1a2VCCM3EYIq/9pX2gvFt+OAhOr8a10Ww5Zz2SvCOtCx/C6FC8Gpt7E4RAHUGDgkutDSiSEdgNwkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFy+wSPBvFvdZ2gtSY3G31NTxidzoa/eLUijaIoxp6g=;
 b=bwjelKwYOUN3vzIJbqlAmMxLjzVaz8jj83pN8ZFCj3dCuF5lVqA1jq12yRdQTNzT4TB+xOvklKEy1FjHPAup8JFTD5rVInGaUoHl5RqzIHPmn8/v+GB8LDjnidG2IL/a7AED+Y8RB/fHL4z8En/e2PbICFNXmqUPQFsjFfO21NXbCaZ6HkUGQEUGcLwrDf/w7Xfb3zYUkY/IXbDDp80HLpjByGs7356DzIlQ8w3jawGveC25ltsu8XdOibs8oay47+3GuD3m5zSPsFBjMSA7HgNArdIIQ06OClTjhqKHCeDXNp5d2d25NFf2J4TYfX4a8SponqlhPfJNPxSkrspG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFy+wSPBvFvdZ2gtSY3G31NTxidzoa/eLUijaIoxp6g=;
 b=TYwqXjn5HEPmnYSkfQVAnVbhI7rqy7jdmVaZyeph0HPaqIMbrL5HrMXiS7n1IV9BSw4yJaYu1pUk+GnuYhlN6hsOqdmd9J/BzkJWiMI5P57TWFITW6RMtb8iZ2R9QexFTEqrOTxEV2bmIaNuB5lHPDbi3kp4zJ+NTshKW0Q16e0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5983.namprd10.prod.outlook.com (2603:10b6:208:3c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 26 Sep
 2023 22:55:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 22:55:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <aglo@umich.edu>
CC:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsAgAAR7gCAAAN6gIAAI0qAgAAaJQCAAaJvAIAAnDyAgACbWYCAAITYgIAAEVeA
Date:   Tue, 26 Sep 2023 22:55:11 +0000
Message-ID: <D7FEC2E6-7479-4925-86F3-E4D163E8CCAB@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
 <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
 <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com>
 <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
 <CAN-5tyHHibZbJh-A=0n3d=Z7GVL1xuYz8H2ygu8HbnsrtUTUxQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHHibZbJh-A=0n3d=Z7GVL1xuYz8H2ygu8HbnsrtUTUxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5983:EE_
x-ms-office365-filtering-correlation-id: b2ed95e7-5c2d-4a34-7ccb-08dbbee3a3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBoSaCpnj3Csh/dJhoxcA8XoDHM7N9DH01fGqBlpBt+zIM7TukQ8hQ9bQqw6L9YoCrP2UkbNsjFFyyBkyREBRjVjXXbS6ZhZUnQvj+t7GGDBT73AURQlzUx705505uFNMMFf4uw5ccIZPqUtf1NYr2z14+5RThZwJs68nJM4YJfbYGYuVGtL2nI9tOTb2EjyFnbe/zutm/P/j2u7yEVHYXpWtAROqdcFtj1oyMcVe1n84R3jkkjwhnXh7UThMrDrmr/fbkNuO0Lpu+4Ebx/+5NDutQnzaTTWV+9NBDiM99RHVkjEcNvzovuJSzTcc9hCIxji6sPFTSqtONlcp5tBGUsTykbk0AFGv+wIpcC+8dFXFYE/MScMWz75PnpNz/cnKYqzk/xCHLlCO416lVaFFM1+Cytt5wiDF0SKWaowAwTEWqFtLH2GMK2LAth9rIbDZZz1fNY+5dF0gUBZE64II0G7vx3zKM/sXboSks65jQ9Vo2hSyNx0Gjkq6eD/DtKR9zIBb5KIwU0CAMFOXZ3j1XChKP8pdYxZVX3unNCJOhCdpEn/wppdoJc8EtXqE4S7zKk+/bRMe2yCPYNj+6MjN6jGUJ0GuY+W/+nSj829DF6Vmg4WJMOFMHWneBsq52BHwdhMPMhOTEUNZhjayXkW+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(71200400001)(6486002)(83380400001)(2906002)(6506007)(478600001)(66574015)(76116006)(4326008)(8676002)(26005)(5660300002)(8936002)(66946007)(2616005)(316002)(66556008)(64756008)(66476007)(66446008)(54906003)(91956017)(6916009)(41300700001)(38070700005)(38100700002)(6512007)(53546011)(122000001)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERzdnU3MGZESGdUazl6dEprbndjeVYxeXFKSmhiM0JkT1Q1dWhaRzU2RVZO?=
 =?utf-8?B?d3JDN090VEF5aWlLSWNQYy82UWc2NTBUa3p6WVVZblNCVWJESUZEcEN6SXh3?=
 =?utf-8?B?aE55MUlRODRkNEtnbk5VQldyTyszVGFoRlc0c1J1Z1RZL252WEk4emxKVlkx?=
 =?utf-8?B?TS9lZFRUV0YwRHo5bTkzSFVsVW1kckFDTmh3MDRxOHBpaVhQTVN5cFhMdmow?=
 =?utf-8?B?Qnl3Mk9WWlhpbzB3UVpaUGJiYUl3MENhVzd6TVMway8relZXbm42aStRLzlu?=
 =?utf-8?B?WjI5ajV4MEJpcmNIdlp4ZGtheGo5djZPbXRUQ0toVENrZVJ1Y05EcTluaWZ6?=
 =?utf-8?B?YUJKcUlrVlBRYm9lWFN4aUt2N3NXbUNOREw3N2dIMGVlZGRZTkZDTFN5RDBQ?=
 =?utf-8?B?ODJFSzVINTVGamdsWDhqUkw4am1QanVSUFRiMnI3ZDJCRDlCNHVMRy9KWEp5?=
 =?utf-8?B?L09RMmNrL2E4STQxV0M2dEpCVk0wTFlieklIU3BLMnl2UTNNZjZpcStoZGlz?=
 =?utf-8?B?bStLUlB5dDI5WFc2dWhCZ0Z2dHVwWDZaUmFQTGdpY2ZJbC9RbU81QlJieU4r?=
 =?utf-8?B?ck1MSWV2RzVMbEtWMkUyWm0yZ1hDSzJmdUFCNnJSc3M5RzUxL01wSXhZWTU1?=
 =?utf-8?B?L3Izd2IxMlhvK3VFQkhsQm8wWGdzNUN0YXNsTmVIVzdXQU9sdzFQOWYvekV0?=
 =?utf-8?B?ODFrU3orL25DeXd0ekVWUi9MQzIwWnRkN2RyYUo4Ykd2TldpQmZPd0lYb24y?=
 =?utf-8?B?b2ZkTHJ1TVRVOHFoR2RvZGtEMUNuWEVvdWhoenk1K3EvNWZydVdZaTJxektJ?=
 =?utf-8?B?eUtRR2hzWTN2UGRvTXhyUHdVOHNFSHBnT1ZNRkJGWWZ0VmNiUG52NTk2NUVD?=
 =?utf-8?B?Ykt0QXpKVENrUVNBKzdsdmlxMkRQYVBnZmNibXdYdU9kQXdrTlN0Z2p5anp4?=
 =?utf-8?B?ZllreTFVK1VXMEEvdFNMOHlNbXI0TXc0eTIrb3hGaEp0MUJVZWtYNnRBV3Nt?=
 =?utf-8?B?em1udmx5ZC9LY0VsdVpNNEVmZWo1cFhub2tuT2pxYk9zWllFYTR1dEI2eUpZ?=
 =?utf-8?B?Y0lrTy9MMU5rNE9GTnFib1c3eGVuNCtYaUd5RTVXR3NyZEliT1NpbExtb2c3?=
 =?utf-8?B?TFZHTVlzSlczWWc5dDhMZ1ZDVDZLRDlmSkZ6RmdMZnNsSVd0NFFITTBCZGVL?=
 =?utf-8?B?SmR3UGdvRVFDd1pXdytEelM0eUN6M2N1OUtlTE1kNW51R1RvLzIxdXlXbWdR?=
 =?utf-8?B?R0l0czhsVktqM2JwbHFkS0xBUG1pckdCOU8zWTRyUFdjVW5pa2I3SjN2QXps?=
 =?utf-8?B?Y0paSkZJcm1nei9qeGxZbDdwSzNYQUFoWWJXZHd2K1BJM3pVaGtxU3FxT2ZL?=
 =?utf-8?B?b2JrTG1UZUF3TjRLTUh2K0RYR0FpU3RWcUx0TVZDQ0d5OGwydjJLclB4WXBt?=
 =?utf-8?B?dE5BSXVVNER1bUFFUVdMaXJXVmdtbTF2T3JINTRxMUNXNHdYMFBET0E5SXRp?=
 =?utf-8?B?blFBeWNsNVVHM2hQOWY0ekhhWCt3NGhPVHJSNzVTZXVIT01BTUFjL3BJMTk2?=
 =?utf-8?B?TndJUUJnRm1ZSEdpWjhnK0JaTmFsNks4MDdLVWdXN1RuTmpqNmJwUUR6Wkx0?=
 =?utf-8?B?TW1kdS9XaEpZL2JQNmdiam5KRDRqaWZJSTlKS2tyMEVuTlgyWm83ektuWGpR?=
 =?utf-8?B?UzNiYnVnb3k3dzJLMjErdTM4N1dwaFFJeXMwb0tDN0RQSXdGMDU3ZzlvOVRa?=
 =?utf-8?B?UnFiQkd4YkFJaXJ5cmp2YmVyU2wxNkZ3clUzSUx5QTJuWnBoYjcyQU41NW9u?=
 =?utf-8?B?ZVAxMk95MEN6WWlSZEwrTTZDZExBMlJySWIvejBHUThwZWVXUllpUFN3VGdT?=
 =?utf-8?B?SnlaUDl3TjdhblpvcU1BVUlvY0pzdTR3VmNzUTFKUE94RWNjbll1WDdhdHo3?=
 =?utf-8?B?VnEzRzRIMGNBZHpqRzNyZjQ0QUdwNDdDSmYvTG5mS1VBNUsxajgxTlBZdDkx?=
 =?utf-8?B?RXZyNVgzOEVNL2RwNlIwRFoyN0FsR3YrU3VvZEZKQ3hkeURmbDNnNWdKeCtz?=
 =?utf-8?B?MzllV0NsV3RNL0RrL21sQzE1VWU1OXlwQTJEWUVmakFyTEJMRWd4Q2ZaQWt3?=
 =?utf-8?B?bkZRR2dRSVZXOXpqeFAxZ0Fhcnd1TDFPcktURXhSU1NiMkVWeE9qN2MxVlJO?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AF7D16360B00488620044CA82E2F40@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QkaMcih2MUNqO97blZe4WR2xmZassJb5FguT8gsQRswrJm2zs7My74jJ6QdOCBTlApwN81t2tV6YrtJGgdG0UciuWai+dBP4DlLTKNcRDTfNjTYRSOP6x37tKcBeM8B3LC9FdFJkoFAJKamWqQGSLABbd/bEttbvZzDDuMiAKJGMAi7/XGUT/64Q5zX5M+8GleXuzQdW647+8uvmMl6d1Tp8VjebwiDvElKYS6oSh5POJyFFvu1jcrJT2hMW2MAxClgh0iww8foeL9hOLoiwHAhmBgyF+AUuwWa6uUsBOXUvpROeLWRlpbx684LHGdk6MtwwoiMxO12ffrX4tV/bjt8y7a+/ld9ChvUTAepp3H5AS1hJixDNeiU86yLcH7uASeJ9Q4vQ0+XpbL74HpUmWaB6/LtkiJPZHWaLV6MY3ERocN3V5uNov5ys6PiAwXu0hYcFMWExQM6YywqbD3ar57QsUl9C+N8zpav7Sb7LH3iVd/Jy0y6L0Ng6tQK3Wfi+mTfbxFN0+n8BKG6EWgh+5KsZtM1Gye2GKTHg4krwPXXUlVH7gJCxn3f+lmr8eMHE4i9ZfR0d0+EU3oPdImY8CKhuNxdrFrOPgDky9BcfUKIoF7B501oVD7YwQOO7CWBycNGotocGWHEA6hEY6uQolNpCR/HQlaGZdCUYTlBuQZS+i4iPBdEagv7Xr3tkLc08jvIFyC+nLggKgISPqmnkR1ybTzUuJaxGt39/037PwMD2Z572LlRDs2DoLR2OlUWGFwPoTgfzH3t6A1AbGzsMu5tHua50jQtKkejNCy5DrmWOPP1vcyM5/b7vIIIvhgm+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ed95e7-5c2d-4a34-7ccb-08dbbee3a3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 22:55:11.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNB7FqVXUAVqmp6xhxz68cKpeWas+iMAHzrvHa4U9Irbili4fBQ4IVcb+ABtRwEy0zRPDlfPv2D+eJ9lzLxYMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260197
X-Proofpoint-ORIG-GUID: kGDZjZybYisatPvJjCKhhx0TJEquemoS
X-Proofpoint-GUID: kGDZjZybYisatPvJjCKhhx0TJEquemoS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI2LCAyMDIzLCBhdCA1OjUyIFBNLCBPbGdhIEtvcm5pZXZza2FpYSA8YWds
b0B1bWljaC5lZHU+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTA6MDji
gK9BTSBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+IA0KPj4+IE9uIFNlcCAyNiwgMjAyMywgYXQgMTI6NDEgQU0sIE1hbnRhcyBNaWt1
bMSXbmFzIDxncmF3aXR5QGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gMjUvMDkvMjAy
MyAyMi4yMiwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+Pj4gT24gU2VwIDI0LCAyMDIzLCBh
dCAyOjI0IFBNLCBDaHVjayBMZXZlciBJSUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3Rl
Og0KPj4+Pj4gDQo+Pj4+Pj4gT24gU2VwIDI0LCAyMDIzLCBhdCAxMjo1MSBQTSwgTWFudGFzIE1p
a3VsxJduYXMgPGdyYXdpdHlAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiBSaWdo
dCwgd2hlcmVhcyBvbiB0aGUgc2VydmVyLCB0aGUgZmlyc3QgZmlsZSBpcyBmaWxsZWQgd2l0aCAi
SGVsbG8gV29ybGQgKDQwOTIgYnl0ZXMpIiBhcyBJIG9yaWdpbmFsbHkgdHJpZWQgdG8gbmFycm93
IGRvd24gdGhlIGlzc3VlLg0KPj4+Pj4+IA0KPj4+Pj4+IE1lYW53aGlsZSwgNi40LnggKEFyY2gp
IGNsaWVudHMgZG9uJ3Qgc2VlbSB0byBiZSBoYXZpbmcgYW55IHByb2JsZW1zIHdpdGggdGhlIHNh
bWUgc2VydmVyLCBhbmQgd2l0aCBzZWVtaW5nbHkgdGhlIHNhbWUgbW91bnQgb3B0aW9ucy4NCj4+
Pj4+PiANCj4+Pj4+PiBUaGFua3MgZm9yIGxvb2tpbmcgaW50byBpdCE8bmZzX2tyYjVpX3dvcmtp
bmdfNi40Y2xpZW50LnBjYXA+DQo+Pj4+PiBJIGZvdW5kIC9hLyBwcm9ibGVtIHdpdGggdGhlIG5m
c2QtZml4ZXMgYnJhbmNoIGFuZCBrcmI1aSwgYnV0DQo+Pj4+PiBtYXliZSBub3QgL3lvdXIvIHBy
b2JsZW0sIGFuZCBpdCdzIHdpdGggYSByZWNlbnQgY2xpZW50LiBTY3JvdW5naW5nDQo+Pj4+PiBh
IHY1LjEwLXZpbnRhZ2UgY2xpZW50IGlzIGEgbGl0dGxlIG1vcmUgd29yaywgd2UnbGwgc2VlIGlm
IHRoYXQncw0KPj4+Pj4gbmVlZGVkIGZvciBjb25maXJtaW5nIGFuIGV2ZW50dWFsIGZpeC4NCj4+
Pj4gVGhlIGlzc3VlIEkgcmVwcm9kdWNlZCBhcHBlYXJzIHRvIGJlIHVucmVsYXRlZC4NCj4+Pj4g
DQo+Pj4+IEknbSB3b25kZXJpbmcgaWYgSSBjYW4gZ2V0IHlvdSB0byBiaXNlY3QgdGhlIHNlcnZl
ciBrZXJuZWwgdXNpbmcNCj4+Pj4geW91ciB2NS4xMCBjbGllbnQgdG8gdGVzdD8gZ29vZCA9IHY2
LjQsIGJhZCA9IHY2LjUgc2hvdWxkIGRvIGl0Lg0KPj4+IA0KPj4+IFllYWgsIEkgd2lsbCB0cnkg
dG8gYmlzZWN0IGJ1dCBpdCdsbCBwcm9iYWJseSB0YWtlIGEgZGF5IG9yIHR3by4NCj4+IA0KPj4g
VGhhdCdzIGdyZWF0LCB0aGFuayB5b3UhDQo+PiANCj4+IEknbSBsb29raW5nIGludG8gc2V0dGlu
ZyB1cCBhIHZpcnR1YWwgZ3Vlc3Qgd2l0aCB2NS4xMCBqdXN0IGluIGNhc2UuDQo+PiBUdXJucyBv
dXQgdjUuMTAgZG9lcyBub3QgYnVpbGQgb24gRmVkb3JhIGxhdGVzdC4NCj4gDQo+IEkgY2FuIHJl
cHJvZHVjZSB0aGlzIHdpdGggdXBzdHJlYW0gY2xpZW50IGRvIGRkIGlmPS9tbnQvNDA5MmJ5dGVz
bGVuDQo+IG9mPS9kZXYvbnVsbCBicz00MDkyIGNvdW50PTEgaWZsYWc9ZGlyZWN0DQoNCkhybS4N
Cg0KW2NlbEBtb3Jpc290IGN0aG9uMDRdJCBuZnNzdGF0IC1tDQovbW50L2JhemlsbGUgZnJvbSBi
YXppbGxlLjEwMTVncmFuZ2VyLm5ldDovZXhwb3J0L2J0cmZzDQogRmxhZ3M6IHJ3LHJlbGF0aW1l
LHZlcnM9NC4xLHJzaXplPTEwNDg1NzYsd3NpemU9MTA0ODU3NixuYW1sZW49MjU1LGhhcmQscHJv
dG89dGNwLHRpbWVvPTYwMCxyZXRyYW5zPTIsc2VjPWtyYjVpLGNsaWVudGFkZHI9MTkyLjE2OC4x
LjY3LGxvY2FsX2xvY2s9bm9uZSxhZGRyPTE5Mi4xNjguMS41Ng0KDQpbY2VsQG1vcmlzb3QgY3Ro
b24wNF0kIGxzIC1sIC9tbnQvYmF6aWxsZS80MDkyYnl0ZXNsZW4gDQotcnctci0tci0tIDEgY2Vs
IHVzZXJzIDQwOTIgU2VwIDI2IDE4OjUyIC9tbnQvYmF6aWxsZS80MDkyYnl0ZXNsZW4NCltjZWxA
bW9yaXNvdCBjdGhvbjA0XSQgZGQgaWY9L21udC9iYXppbGxlLzQwOTJieXRlc2xlbiBvZj0vZGV2
L251bGwgYnM9NDA5MiBjb3VudD0xIGlmbGFnPWRpcmVjdA0KMSswIHJlY29yZHMgaW4NCjErMCBy
ZWNvcmRzIG91dA0KNDA5MiBieXRlcyAoNC4xIGtCLCA0LjAgS2lCKSBjb3BpZWQsIDAuMDAwNTk2
NzkgcywgNi45IE1CL3MNCltjZWxAbW9yaXNvdCBjdGhvbjA0XSQNCg0KLS0NCkNodWNrIExldmVy
DQoNCg0K
