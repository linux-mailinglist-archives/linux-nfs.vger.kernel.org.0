Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F37ADF82
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 21:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjIYTWn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTWm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 15:22:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E32BE
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 12:22:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PIJTkA030439;
        Mon, 25 Sep 2023 19:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4lr1nDtfkkjizMkrTxXszlJ+ffDncxR41a5Q+/WocJ0=;
 b=trcDtFIGwFZ7VvKWnBrX9/2f1It+nv6SZowlCZ4IXdKAq0WUdw5qc1Z4B1s8sj4iaQNP
 XMs6G/FYZEOJW26c+zE+NwjZFkncl1YrsWbsklayU42wsm0eKSlBdWJxHY4IpZH1YmgI
 MddczABRsyI6or0+1J2xejW0bgcN/7VhOozDTyOAAbQDwcg+VjsMFcdgote2GiT9NJqY
 dHWgsPO2mJzrCUJCgyDm+yvBV31nFs7feE9c86DcPyyPSPln546wAlgoNwnB8JQ5jhp/
 Q3FMbwWJ3zlsU6K7ATUhxJY285dz//9KfbsIjHSnB03LcmnfU4EkVmDTBd56h9vxa+OY jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuck3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 19:22:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PIiCt5034909;
        Mon, 25 Sep 2023 19:22:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf57f60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 19:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpkZNhUiHCtysUN1Pjq9Kg3PRqrrtiBstcY4iGurjvTSrO10ZU2DB0LxX7QyD3eG/VRdMLrR+BA0AXdNMpuIFWnxZ3XgrQD/75D7Poz2+Owj6JA8eFKiYkDLnoSrkM6JN/R4nIWNjfCQ2GfNEWlbmSapEVB4W+qjDdTqXnuPr/nPrvT0eF8N9xreMO+1vUpygpN/jakeAL+T8IxMXfZIs+aCT5VQgPqubILWLKG2q4nqMP681TmTQcfWNjG5Gf8u4g4/ne2B8DPPXGB9WfCGeb8R1mSlIedUz8vr/U3V5i7FMWjyKpCgfUxy0GfJCjM61+lqaqr4+4/zn8IqLvM3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lr1nDtfkkjizMkrTxXszlJ+ffDncxR41a5Q+/WocJ0=;
 b=TXcTFrDCyU3VW+tPtq8OIpuQL9thzWdWETD28sBqpGTuiLG+Epiq6wkrwXegCmb3BDkD22nva6zeSnIYimGDsLsTaoSRuuGPounZjNG80Jl+rkzRzDhnq/Zruohux5KpocZ8OXKaj+rndp9PYHH4QEN3xyCwbbnMJJmoMykvV8xhKq8ja4R7KGcGmBzbpQd2oF/FIokh4G+CgSIQwdaM6hwAkiMW+9oVd4rIsik//XkFLTsWcx4T0lObM+KhXWvF56l+HVeSejVDjBumNpWiPZID0vB8ZYHjPJ0ZoIFBjSunFek7RAG72pThYWT4O55hNHRfWmB/85CeFIHRKvq6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lr1nDtfkkjizMkrTxXszlJ+ffDncxR41a5Q+/WocJ0=;
 b=VEQWZQKCAJ9FjZXvZtHcLIMmKGdQJQFNpYdeyyVggdQjCdlXc/nkdUMCbfi44vvG8YYzs68jv0aQRRmwfYd7gEeopv8Bw5c098pndx79E5eNwDUF4vTpJHHVU1ZPC6uLRPWIn7VqDTuqtlWbrZBkAi/9YlDfp0LoPuuQuyomSoc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 19:22:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 19:22:28 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     =?utf-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
Thread-Topic: Data corruption with 5.10.x client -> 6.5.x server
Thread-Index: AQHZ7uglcAk7YvaB4kSAn1xCF15i5rAp+BsAgAAR7gCAAAN6gIAAI0qAgAAaJQCAAaJvAA==
Date:   Mon, 25 Sep 2023 19:22:28 +0000
Message-ID: <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com>
 <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com>
 <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
In-Reply-To: <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYXPR10MB7976:EE_
x-ms-office365-filtering-correlation-id: 408ced5f-4c2e-4455-bb96-08dbbdfcc1de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgAn9TAWTAMiuvTkqZiqx0S5ItKMxgCDd29SeVeg9jGxiH29/b1jH0ay+948lf5gMoabPQT2M+9radXzNqQ3Ipmxp/diwi9nemBStF3HAHBjT3exbuRgzcN5YVUxmNopMoGawL10omZsHtoRGwMlDEffvVApuHArQofXEA+1zFl3VIZP5gl2WTWH1CnzWudaXXdOQJ6DU6mEO0MSuE4/O+Nf+PPMC938FLjCxxJ+vz0icZfAVK1DvvDLRxyQjxKKfGgRFkz7Dj2rUW/Kuoc7TT8t/G91G2d5HwwI8nOD7RtaX8i1AX0d8BSSE03FAiNk5cbyRbU8a2R8CyqMGnlWSJdE95wr3KIkGJlUpzbpiTQVRNK5hCmmdNGisVyqVXwmbRZO7xjKk/eJIHBhIXBGwkFIOZswgTA6zsbjmWAVmtdD/7v+pUmS68kdYv7p4Ov/3QSbVbiZcT6okrbNLNAqOo171cjklqCskqMg0Gkm+e619A78/wtk9pnZA6L0xe3k+KE/S1UdOROfh/mMhCMCxZIDMWf7zI73377qeEcSY4/Xqh57M7K0P71Dcuag96PVhnOV1HlhpP2D0R9+9wdF3tVs/ufRB7uw2h91XNnpxulFhN0AgAAZsTgekiUKJ2hqZRuSx9NAvNqyy5ubUtWTAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799009)(66946007)(4744005)(2906002)(5660300002)(76116006)(4326008)(8676002)(91956017)(66446008)(66556008)(8936002)(66476007)(71200400001)(478600001)(6512007)(6486002)(53546011)(6506007)(2616005)(316002)(26005)(41300700001)(6916009)(83380400001)(64756008)(86362001)(38100700002)(38070700005)(36756003)(122000001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWw2K0JUNDhubjlWV3RRU1JIMmdiRmQ1MHhyZCtBSkIydzE2MmVmSlEyQU9T?=
 =?utf-8?B?YVZlbjhyZ2dxc0Z3dlZFQ2s2aGhqZ2VKRk8rMitnTDE1VWVwNit4ckNPckRy?=
 =?utf-8?B?SVFOWDROK1BSN2UwT3VCYk4rNzlPWmcrWkEraVYxYTBzTVBZOW53ZjAyQmwz?=
 =?utf-8?B?YlVrZlBaeWQwdW42Q0NWS1duK01OWXRYenVTN0dOcFZLQWtVSE9KM2NlcFQ2?=
 =?utf-8?B?MkxzVEJaei9rTDlCZVhmVFNCbVVVcXV6ZVB5Z1ovQTlEayt6N2kvYzFnME9Z?=
 =?utf-8?B?NTR3eENWS2laMHE2MFVLdjdhdDV2WFRxOUlNYi9HMDYwNm05Y3RGZnVLMXN0?=
 =?utf-8?B?R2hRNDc2SkZzMlBER0pnR095K3gxT2xQZU5RbW5McE1Ga2w0WURXaWtBNWpn?=
 =?utf-8?B?aGZrNm1JRzJxczA2ZllZMjZ2dEVqOU0rZkpXcXhHVnNKaFdmRHhhLzYreDNH?=
 =?utf-8?B?SnVzbW9MeWF0OVM0bFJ1TFhXWDFDeDUxQ3cyTTgwQ0c5NVowVVJvL20vUW5j?=
 =?utf-8?B?RTFRc3JrRXk5Q2E1d2x6dTdGQ1drNTdhZXZoZkp1UUhQSnVuUjB5a3Vpd1BH?=
 =?utf-8?B?aE1heG80YTFxQjRpTC9FcllsL25zWThLc1Y4ZHVCcnB3aFdnUDdXTXZHRStH?=
 =?utf-8?B?TnJ6ODhWLzQzZDFyNFBSWXBDRjJGSWV2bmVuR1c4NFBldktwbUFuNjZ2WHN6?=
 =?utf-8?B?Yy8yZlRRc0JMMUpVdkhiWGZMNVB2dmxabHU2LzduVk1XNnBBMTM4c0FSbHJC?=
 =?utf-8?B?M1pRczE1eG0rUm9KZ2JOemFVRzZBT2RBa20rWVN6R0JkVGx6WUd6SUVZY2dy?=
 =?utf-8?B?aVUwNkp1akZ3NXVvUTNhUjNXOGxBRnphVFFkQk83R0NJMi9WNUozbkppZ0hq?=
 =?utf-8?B?UUc4ZGtpMlQ0TEkxSkVRbU5yVmNRN09xLzVocDZKZzE4S01JVHZSNWNJMFJY?=
 =?utf-8?B?a3FDREhCS0VlalR1R2tmTmViNGF2bk1lNG9pVW1DcDFsdlZPbndwRnFWQ0Qv?=
 =?utf-8?B?eXdnU2g5MGZib3RzanZEaWtkQzhqa2VFZmQrcmoydjNKYURJVG54eDFrdUsz?=
 =?utf-8?B?SURmdkVIZktIaDROSzVIUU5nNlFUbjZxVDZicldUdEhaREVQV0FMQVAzVGl5?=
 =?utf-8?B?Wi9PZkEvZEZ6Mi85WWdxVFhyUVV3d2dkSkJiMFptTHdkdm0rQ1pjbUhrd2ZS?=
 =?utf-8?B?N0Z2WXlhZHhtSEt6Ry9hSmhPZGhXMEM3SGwrQjYrNDJSMitxbnJhdWFmQVlx?=
 =?utf-8?B?ZHcrV3psTWgwSENGcXk4MTk5aXcrVmpVYkdwSFF6TmpyNWQ0VHJuUXFNNFlE?=
 =?utf-8?B?aVFXa2dnQ21BTDgycVFleG5Xd2J5SEc5dGp6YmVGQmtKZHIxZUVSbFp2bnMr?=
 =?utf-8?B?Mjg4MmVQTXp5NU5Hb0FDYkdtLzV0YUF5dzZQN0UzaEF5eGw5eHE5WU5GZGQ2?=
 =?utf-8?B?UzRiTVB6c2dvdk8xbmNRcHE2UzVRY254SnROOVVObGxSUkZEeTZMMDE3MlZp?=
 =?utf-8?B?ZWVoaXdoUll4endtdjJCNjBSUUVCU3F3STZOMmduc0c4V29SaHdaVGVhbGhT?=
 =?utf-8?B?U2hOaU8xNTIzUlZnQjBlbStvbTJMb0VnN25Cd2o5RjE5dG1mQzR2YzBNRitM?=
 =?utf-8?B?UW8yaXMzcmNhTWMzSzl2eUxVamk4VStxUlNWeWd4NVJRWUZDVzFCUzU3SHRW?=
 =?utf-8?B?Qm1JdW1ZdGZaYy84UmNwM1B6N1BobDBQMmxoWE1JU2ZIc2N6K2doY005ejhF?=
 =?utf-8?B?UzAyZUh1eEJ0U01iQ1U3S201SHc3UTgrUUM1WWRJYVloa2wzaGV3MkV2cmZO?=
 =?utf-8?B?eW5xZHgwelBFSjZWOU5CcWJIQisrZGUyMGl5ZzZWOHpLT3VnR1kzeTRDR2dK?=
 =?utf-8?B?S1M2MHVCcFgyZTlDODk5blJ0TE1CQnFzNzk2bzYzd0NyUnNScncwbzZRVUxJ?=
 =?utf-8?B?OHl6VURlVDA1VmFid2JkT016S0tDMk9ISG5YS3RJSVZ1cXFwSzd4OWJPSStD?=
 =?utf-8?B?QjQ3VVlkTFh2ZjJBUE1vMVZEdDV2WVNzeTZsMUxrM0dUR280cE1LUXZLaWgx?=
 =?utf-8?B?Tk1Yc2pQamV5blRKV2RUWG4yNVIxSUg0cFo1SWZhOU90V3pNamlUbFJvRGQx?=
 =?utf-8?B?RG05MFdIMjR0anVCVVFDSzdEMEJDaVpBL25ESE1BMjdxN1lHOEhaRythcTlS?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <775A3BEF68355C4DB391924D23DABD86@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gP6R1yRh3Vg3sh1O7BMaRXZ5GlB++BF/aSwXRZCs5KcSkPNlZJTDfdxLxfJ6YQ1ulfis+RGnf2qWq7DMK1zqawkBNtiLlUsOqLBvITlOLb0yNMDZuL7pm4AuleCKwoVT4WbvuXJ6PufMU5XYPOWIdvjB8QPAFHHAW/ajK5jPv8CiKdE424YE2Sh2maQBTLAIPJfMNqeD8InOn4GiryxCXEfTEhopQ4ylESRuEikpERekdVWohL6piLiiDH9LwgJpBBCuPl/4bEtyjwdO2gFnzLtrx6rQokfhikuOvBGOsBns0c4O+h7emaJFdC1qzJS+PdaDosqjTrRG0baJUMuVhyn9x3oMqdVaoYj5TCJSBcEovkz4/vVWqlA+IWU/u7M4awq/HFL+uMU3aq1YLgsbnhh+b50zTWopokqETROYB41VEAhadapfRd6jKpZZIPEokU9RvCotlKbfKfTahg6tN9jsQ8tEGSFeDM/LRAA0MI5eIe/W8HHg1G7/LBLzu1mSgl1f3Eo9Qc4jHQ8rz9w/rfOYUz7RyZfjE22rpySnHpu8HZjvizckosDNFfXWg2HZNlucZyRF37+3Yz2DpxRzL/xocwaEr4B09e1Uu4EEUJRjx1hZ/WH3S01/0feF0dVptqq39rBGlZfyA/gO5E0XiWiRAbm/kT/1lYujOxlplbpwXGQzgswOliQ+tSBNzzJjdZwWttHuE3Gx3K3k2tCPJYjGCb7887/2MuVcXXNVmgHFppfVc+TJGObb+QnKcAWJCMzo5XLmPWEX/iYRyk+3N/AK0vFCg32mvbroJet8Mk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408ced5f-4c2e-4455-bb96-08dbbdfcc1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 19:22:28.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRZcpIxeU3CBJSFNLFdR++qxR8qZzRzvYvjgg7IdX9MkTUFtyhGbCUmJvYWLNqmSZpoAi1NsdG5GtSZ/T9suYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_17,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=959 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250151
X-Proofpoint-ORIG-GUID: ACwW0lcAwc4lZc0Kws-a9iSSKyyf_RXy
X-Proofpoint-GUID: ACwW0lcAwc4lZc0Kws-a9iSSKyyf_RXy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIFNlcCAyNCwgMjAyMywgYXQgMjoyNCBQTSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5s
ZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiBPbiBTZXAgMjQsIDIwMjMsIGF0IDEyOjUx
IFBNLCBNYW50YXMgTWlrdWzEl25hcyA8Z3Jhd2l0eUBnbWFpbC5jb20+IHdyb3RlOg0KPj4gDQo+
PiBSaWdodCwgd2hlcmVhcyBvbiB0aGUgc2VydmVyLCB0aGUgZmlyc3QgZmlsZSBpcyBmaWxsZWQg
d2l0aCAiSGVsbG8gV29ybGQgKDQwOTIgYnl0ZXMpIiBhcyBJIG9yaWdpbmFsbHkgdHJpZWQgdG8g
bmFycm93IGRvd24gdGhlIGlzc3VlLg0KPj4gDQo+PiBNZWFud2hpbGUsIDYuNC54IChBcmNoKSBj
bGllbnRzIGRvbid0IHNlZW0gdG8gYmUgaGF2aW5nIGFueSBwcm9ibGVtcyB3aXRoIHRoZSBzYW1l
IHNlcnZlciwgYW5kIHdpdGggc2VlbWluZ2x5IHRoZSBzYW1lIG1vdW50IG9wdGlvbnMuDQo+PiAN
Cj4+IFRoYW5rcyBmb3IgbG9va2luZyBpbnRvIGl0ITxuZnNfa3JiNWlfd29ya2luZ182LjRjbGll
bnQucGNhcD4NCj4gDQo+IEkgZm91bmQgL2EvIHByb2JsZW0gd2l0aCB0aGUgbmZzZC1maXhlcyBi
cmFuY2ggYW5kIGtyYjVpLCBidXQNCj4gbWF5YmUgbm90IC95b3VyLyBwcm9ibGVtLCBhbmQgaXQn
cyB3aXRoIGEgcmVjZW50IGNsaWVudC4gU2Nyb3VuZ2luZw0KPiBhIHY1LjEwLXZpbnRhZ2UgY2xp
ZW50IGlzIGEgbGl0dGxlIG1vcmUgd29yaywgd2UnbGwgc2VlIGlmIHRoYXQncw0KPiBuZWVkZWQg
Zm9yIGNvbmZpcm1pbmcgYW4gZXZlbnR1YWwgZml4Lg0KDQpUaGUgaXNzdWUgSSByZXByb2R1Y2Vk
IGFwcGVhcnMgdG8gYmUgdW5yZWxhdGVkLg0KDQpJJ20gd29uZGVyaW5nIGlmIEkgY2FuIGdldCB5
b3UgdG8gYmlzZWN0IHRoZSBzZXJ2ZXIga2VybmVsIHVzaW5nDQp5b3VyIHY1LjEwIGNsaWVudCB0
byB0ZXN0PyBnb29kID0gdjYuNCwgYmFkID0gdjYuNSBzaG91bGQgZG8gaXQuDQoNCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0K
