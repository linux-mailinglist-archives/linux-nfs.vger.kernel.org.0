Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E97F15F4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 15:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjKTOo1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 09:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjKTOo0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 09:44:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEE98
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 06:44:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDobUD028985;
        Mon, 20 Nov 2023 14:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=d8pzfGCnuPq+KvuVOtyqjgiQuywCPtN1MNcVwwCqlX0=;
 b=ZZLHCJAzy4NNc8Hte0ir0IFivi0TUXKAZ8L5yP4gBgMm9W9f4XWbdhut0lTGW3p4AlRN
 yq/6rTHkFyr0cfKmzCWU27Y6Jt1DaQq3Hu7ek1bCuZRUQiXAPLrYIgTb4UhNjIov1krc
 naT1zEU3MDR5Qyf7ePP1zez1Nnh106MIfSGHB7vvJwK6Ub1iZnOYLsUI9bHu1inDJwL0
 76QRYOPVLRl8c2I85IgHExstkSaATHVxqCaIQ3SxQhmrMqJBP68t2ghGp8SiLoHxsGf9
 RYXrvqc3YdKIvMHxnZfaWVvp2KoHYE5DK3Fl3Rn2Ylw0DvvKdLK1TY+TD27ZSujd5AI3 +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2ttuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:44:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKE6Xus023464;
        Mon, 20 Nov 2023 14:44:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5fbmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiUZ4y3G9YaqAJyvJ8+JsMIELZHqoaf+bcTYrI5HxGJPpQOdSw2VX/4H50ogttpbkkBDWVyPCvZRyNs1+vwzRiqYAku6ZTSpXr9U/nrMtwUZWCaH83fEFXrrfTIlNt6z+NEp89o2oDku6DFGak3xhXUOWVpfJIV8wPsTGHZxV6P5lqluJHkJW+wCpsBPwJ6ST4fOOEgw3YYz1OfsPnsq7I2rCbsI9hkQetycZTpV3xvyT5OfbUw/sQgYbw6zUL+Dlqm8stx7PVRcUwyeJ9fMJz61zpsp88es7ihPagb+Wc5sgUaxwW14vswdaEzF66obUaOuyVCR3ATY2XQWsrCtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8pzfGCnuPq+KvuVOtyqjgiQuywCPtN1MNcVwwCqlX0=;
 b=cxL7pAoSds2ILnmCxHHr75whRHdZ0RPmKv1KgLWlYCR6nTzcAn66FLI125Tl4mk5WVFPG3ZbT77kXM/xa6Z2JHYtBz8e3G7kfD4IFliuwcYdKgZiE2dkvnLwBExZ25NkonpheJkdZZ187JM0dan+94gUscLi3N7jQolt5l/dpgOsJlCefsXv2KdFkrGQ5s7WR7fDm2RoZNnDzADFckVRq7QqIG8V3vVhjHMoYCrcC75Rzw8ff8nA1cJiKpcfuVFjfFVS3DtQ6CG9F6z0wQmdoI+zN6q3IJoff8fQOTmqJY8ahrVv685Zcn4B42zKy1pjJU9v0lvjBqAwPRWoQkQSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8pzfGCnuPq+KvuVOtyqjgiQuywCPtN1MNcVwwCqlX0=;
 b=nQM7UIbylZyPN8YXjNpQJH4U5aaT16RBCjCkW1NWbOJWHMo0emjdBgarKBPfyhG5cF/SpTeQYD0DPLeZ2M1GcaMGmTcovagEeyy5aP37GcnlII9sax2DgOVBtdkQ1AlXuhHr12SWjr4w96juf1+fSuuE8sUPLIClihhkvjF7ypg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:44:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 14:44:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Cedric Blancher <cedric.blancher@gmail.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: How to set the NFSv4 "HIDDEN" attribute on Linux?
Thread-Topic: How to set the NFSv4 "HIDDEN" attribute on Linux?
Thread-Index: AQHaGegGMHV8hAgAykqIljHa/PX6CbB/+LKAgAHkowCAAT1EAIAAMZoA
Date:   Mon, 20 Nov 2023 14:44:14 +0000
Message-ID: <628D6042-758C-4D8B-8CAB-BC970EC0EFBD@oracle.com>
References: <CALXu0UdcCKBGR8FUSEeEMngKqwz98Xc2HFXnhX5i_1ioEiuaQg@mail.gmail.com>
 <83a30ef92afa05d50232bd3c933f8eb45ed8f98b.camel@kernel.org>
 <CALXu0UerMnjs9y4gQTvy-v-gqSgO2imFbMAZ87LFj1tQqvfjiQ@mail.gmail.com>
 <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
In-Reply-To: <0d7966163db13d71cb4679d51db5cacf91f42b6b.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7493:EE_
x-ms-office365-filtering-correlation-id: 705560fd-6818-4c69-33f9-08dbe9d72aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERv0vWpTE24AYCUl2PR2HEwjouXAs7YFUls/4o3prtLqwaeymTaUbRl6OtwnMrv8lvbrkaSo5J9AxTG6o/qKrp1UZNIz24vHPJ5QtonI+gJY0/xx95071gxi2shWOToQ7U2M3YfnPWch/0Juo4SEBpOXySSnee45Q8kl4sFwy60O789WAsYM9W4iKGFrYhSDmxOedYI1M1W2DK3C2LQjf9wM/hsn5xI1d6YsregREwAw2EIRYEEYbgC6ZnFrcaCxfKAxB8H+zJrLYhMp0Wzru0ogrrJcA0A/E4Jb9Wz5Owb/JT2Sqly1JA5ly1rSwSvxRPIHNrMWTp2SKJKKWA67zpNUfLRF5OQ1YI/JHRswqMTPElnKkfvNtYHsQYstPzIvQ9Shrkzqp2vzHh1OaPrwGwjtargwhTDLm+hSdVlJ/kgYKfDvnF3wTNEdsOjhfd4hP1M9fQ/PYUNbBLx8V5JaIAXB0nzenMS99foTcGc6midq1Hkh5VKNS4w5/tQp6WOesesXbVujSiQl8uzygNATdzpwR5e5nYcuHDUVioXzSSQh7NnuHo0BdXq+HRSBbzXiOo0Z4UQKZFPC9oBhyoENwmM4Tenuy9V1HsIvDXaEx3rQ1h89DayI6GK1gKjkuOcgOK1RtQg5aB9XzPe+DBoHqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4001150100001)(5660300002)(2906002)(4326008)(8676002)(8936002)(41300700001)(316002)(64756008)(6916009)(54906003)(66946007)(91956017)(66476007)(66556008)(66446008)(76116006)(86362001)(478600001)(26005)(6486002)(71200400001)(6512007)(53546011)(36756003)(6506007)(2616005)(38070700009)(122000001)(33656002)(83380400001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVgwdzhEZVprdXpPVFc1NG41SkgrSzhiVEQ3M3VHVWFCYXg5bXd4MWZUVG5l?=
 =?utf-8?B?NzV1NHNzYU1KZUdZN1BQb0VtelY2ZnJDNXVuYnJxdUVnZ01CN1VpUFdHZDZV?=
 =?utf-8?B?UGVtRzFQcjNBalhxVk53ZHR6QW9pUmIzS0NGTG9kWmJlaEIzaWFOK3R4ai96?=
 =?utf-8?B?QXZiQmlveVRYclBQVVM2VnBlU1U0U2VsNnZ2WTBIbStRS0pUQzlKQU95M01V?=
 =?utf-8?B?bGFseDRYbzN6VUt3K2UxTXhGRkZXQ3Rvdm5Rd29DeU0vNGR2YVZyUDM5Zmpn?=
 =?utf-8?B?dkxoTEJCc0hCOE1KbmNsdEVNS1RsWFFxQ0R3VEozRCt6QThMQ3JYQ2htWE9S?=
 =?utf-8?B?QVAzSjF1WmwvSUduWXZuNXJ5bkVVZEJ2S2dOZkpjM3dvWk8yeGdFVVhIODhX?=
 =?utf-8?B?VXBvZ21qQXphN1hFdEJWVzh1SmxhdlpQa3ZqVmd4STkzdE1jdkZoNFMyUlhP?=
 =?utf-8?B?LzUzVW5HcEZRZzVEOTc4QXdjcXNCTStCU05TTTVkNzBreHpQOFMzQmtIb2RI?=
 =?utf-8?B?NktxeTgvTU9yOHRkNkM0NmNEMkROS0k2Y0phTUdxaUpsQXFUOGpWWis1UmZj?=
 =?utf-8?B?cTFDYzg2UWlTajM2U3htUThkMmd3RzhJUWpIZ0o0WFRZY2RpT1FLanlZR3JY?=
 =?utf-8?B?VE1iNmxmaWQ3WEpHakZQWkV1U3hWUTRWeGJvSXU4ZldadnhMb1MwdmdUSnVn?=
 =?utf-8?B?NUhYd2ZsbmNweUxEOWZWQWhHMUMvNjZyZ0NsYWRiQ0tmTWE4Tzd2cEQrd3VV?=
 =?utf-8?B?dk02KzdTeDZCci9oUlVyZGtOUTRWamx2Z25mU1NhNUhUc2tDaThabU9yTXFT?=
 =?utf-8?B?Qi9nSUk1YUtiQlc1c1p2Ylg4RGVlM3JmRGJrUEhsSTl4UUR0V2xIWFhORFdP?=
 =?utf-8?B?NWVNSzZ3djFUQ1ZVNHZaVE5qRmFBWTdiZXBrNnhWS3BTWVUyTjJ6d2JjUUVI?=
 =?utf-8?B?ais0WThaZGVsdnI3K21SSmtoYmgyZTR6TW1PVEdjdHNjeDE5SHNEZG42L0Nu?=
 =?utf-8?B?QkJmQ3M2MkFQSzZYOUc1dDJscHlMdm5pU2p3WGgwaHJHYi9RMElsbnlNQllN?=
 =?utf-8?B?NEU3aU8xSzFmOG1FN2hidTFSeFdpUVlEc2lMVWJQN3puUHRaMWhSWENBWDln?=
 =?utf-8?B?WkkvcWFzSlA1ZFNadFpnb0s4ZEQ2WmhkVjRyT2x4NHgzcmZKNU8yZFUxck9x?=
 =?utf-8?B?QU1ZeHk1Umx0cnZxdHNoRWtsdVkrSUc4VkpjQmw1dmdOVjVQY3N0SWt5emN5?=
 =?utf-8?B?MzRXTHcxcG8vWTZ6Q1BwYm9iVzdkQzgzUXpjdml3dDlBLzkwcWxtdXJadXlT?=
 =?utf-8?B?N05IeHVKZ0E3MkZiMVR1QTRoZXlDQ29ERzdRNkpVaGVNVkY1MFN2UDdwMUY5?=
 =?utf-8?B?aVU2bDFoNUVPS3pYT0ZPdmhnaWdkTjJXYjZ5UHBpWnQ4WDljMnppd002UTZh?=
 =?utf-8?B?UjFDNk1ydU5mUlRORHlYWWZnWjdjeHhabEZkNC9yU1QvVFJ1a3NGOU5MdFFy?=
 =?utf-8?B?aDFmZ25NT1g5blpzMnkrYVlQZ29IWE4zLzRUcU9nTXhnc0d2ZEJ1VGU0L3Fm?=
 =?utf-8?B?N1FuYkNxTlBRWkJ6VGRjSDU5NWltcVFUTk14bGNKTU9CU0N3NDY3bmZ4d205?=
 =?utf-8?B?cStyVEIyYUYwNVZtaENpSmR5ajkrOWllVlhYWm1wY1VFZzFVbE41Z1AySXY0?=
 =?utf-8?B?ZE5xc0IvMFErM2ZNM2dGZkFnUWdjMm9uRElwMWczbmo4Vlh0Wmx3eTZEZ2s2?=
 =?utf-8?B?TE1PZGhWVmkxanM0anU2ajNsQmk4ZkQvcUVMTGtRTVc0a01rbFAvbGVYZGJu?=
 =?utf-8?B?MjBXT2I1TE45ZTB0UUdZejVTdzJEMmJXbUR4bHZGeDZpQ0ZhNFVBWUhLSjBN?=
 =?utf-8?B?MkZ3SHZPWFFKVzhQcUo5TUJFbGF5eHdzcm1DQm81eUswUEhXaVR2YUdmZmM0?=
 =?utf-8?B?cjdScFhPMzJUa1FPMmNNQ3JFNjNua0dvd1p6em9aZXo3eC9FWTM4UDV3TnFB?=
 =?utf-8?B?K2RoUGJ6RkhmMitGRjl1cGNhcldSbjJvVHE0TWFGNW5XcjRoY0E4TFZuZmh2?=
 =?utf-8?B?WHB4Z1YyVDh0cUpFMEEvL1pXajJpRGsvQmprYVNPcDllN2NIb3Foa0NieE85?=
 =?utf-8?B?RTZWS3JiRFUxS0Fad1FycGltK21RcEtuMDVtcStJbThVRDVMSDBUbmcza29L?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D5A31529E0CB04BABF6C76088DB9BB9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ijOEbB6giH4f/D5e/zk21dXUFGls8Sg+0fveAa/nDTopr+nvHHqITUWUKukluU24KX/4/3XF8+3/pIdsmDe4yb7HqdzX9zdOlxD5s20G3s1lO/heF9Z6PmBRakddy0xyFhmXOL12xQSvXyFBNwVN8V1//Gcx4nNBp85LaNXtkW2uWJMr2d1a7aSMOEK14Q468tNOww2B+LpmDFy1hUSrmANpcUMnwXU8d1q86cWAwtyK170wT3vJtAa7jSYNVILtFt/TNbBlzk4Ehzh8IVjoQupuPLgQNp9RvjiJ5sybBUf137jlErpV4R75QOlGpeSfYagN6xua1S+nzZUfBXiKXh5Gov1ivc17815oOwjESySviNRd+37RzDEYWCfladmhG3oxNBCaE0U5PDxdUdieGH+SkvSVYHChcAWFlRlBBWJFJMB32muX2hFQ01jlsWxfoYjPU+6flHgPLfBif1J/DIZpfrfxfnbdaFks0dcGBRMhNbxE3VV0qNfHJXtByK5Omfva+Dh2CQF8LpXBXhJM12PlA3hUsFFJPASBKzcOGfVX/FLlS6lpovvqV/F5gDxQN6zj/cVC3ppGU5dWsQr8n5A2aZ4yKV3vbGT1A0V8/Ev89z8dJRq2uA102Y2e8A8G04S6l4Zk5a0+hIc84Lbi09hx8CH4wbPHFMtRAAAD+keTyucUamopsi2Nl5YEeSAp6YINnz6UpAy8pp7hPZVdv4F5B0MO5WwwpR/KZTSRhvuC5Qc+KFUCs3RyKWMjfYM7tALo0fsscO8MY9XZ8YXrTJawEgdQBRhQs96R3JBzvkb5FxJi1R9/3rVPOSOAiSPi
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705560fd-6818-4c69-33f9-08dbe9d72aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 14:44:14.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuELmfWu1ct0myOgu/9ORuyko8oUyjJp0Wpkwncw4uMnl3YQ/bXHNxhPdFCSlFVWSmVS6UEnQ8BeKJwiWTCyOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=942 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200102
X-Proofpoint-GUID: 5m6gmJPp5cOx84Go_AMZrfSX2z937v_G
X-Proofpoint-ORIG-GUID: 5m6gmJPp5cOx84Go_AMZrfSX2z937v_G
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDIwLCAyMDIzLCBhdCA2OjQ24oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gU3VuLCAyMDIzLTExLTE5IGF0IDE3OjUxICsw
MTAwLCBDZWRyaWMgQmxhbmNoZXIgd3JvdGU6DQo+PiBPbiBTYXQsIDE4IE5vdiAyMDIzIGF0IDEy
OjU2LCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBP
biBTYXQsIDIwMjMtMTEtMTggYXQgMDc6MjQgKzAxMDAsIENlZHJpYyBCbGFuY2hlciB3cm90ZToN
Cj4+Pj4gR29vZCBtb3JuaW5nIQ0KPj4+PiANCj4+Pj4gTkZTdjQgaGFzIGEgImhpZGRlbiIgZmls
ZXN5c3RlbSBvYmplY3QgYXR0cmlidXRlLiBIb3cgY2FuIEkgc2V0IHRoYXQNCj4+Pj4gb24gYSBM
aW51eCBORlN2NCBzZXJ2ZXIsIG9yIGluIGEgZmlsZXN5c3RlbSBleHBvcnRlZCBvbiBMaW51eCB2
aWENCj4+Pj4gTkZTdjQsIHNvIHRoYXQgdGhlIE5GU3Y0IGNsaWVudCBnZXRzIHRoaXMgYXR0cmli
dXRlIGZvciBhIGZpbGU/DQo+Pj4+IA0KPj4+IA0KPj4+IFlvdSBjYW4ndC4gUkZDIDg4ODEgZGVm
aW5lcyB0aGF0IGFzICJUUlVFLCBpZiB0aGUgZmlsZSBpcyBjb25zaWRlcmVkDQo+Pj4gaGlkZGVu
IHdpdGggcmVzcGVjdCB0byB0aGUgV2luZG93cyBBUEkuIiBUaGVyZSBpcyBubyBhbmFsb2dvdXMg
TGludXgNCj4+PiBpbm9kZSBhdHRyaWJ1dGUuDQo+PiANCj4+IENhbiB3ZSB1c2Ugc2V0ZmF0dHIg
YW5kIGdldGZhdHRyIHRvIHNldC9nZXQgdGhlIE5GU3Y0LjEgSElEREVOIGFuZA0KPj4gQVJDSElW
RT8gV2UgaGF2ZSBXaW5kb3dzIE5GU3Y0IGNsaWVudHMgKGFuZCBrb2ZlbWFubi9Sb2xhbmQncyBj
b2RlYmFzZQ0KPj4gc3VwcG9ydHMgdGhpcyksIGFuZCB0aGF0IG1lYW5zIHdlIG5lZWQgdG8gYmUg
YWJsZSB0byBzZXQvZ2V0IGFuZA0KPj4gYmFja3VwL3Jlc3RvcmUgdGhlc2UgZmxhZ3Mgb24gdGhl
IE5GU3Y0IHNlcnZlciBzaWRlLg0KPj4gDQo+IA0KPiBOby4gVGhleSB3b3VsZCBuZWVkIHRvIGJl
IHN0b3JlZCBpbiB0aGUgaW5vZGUgb24gdGhlIHNlcnZlciBzb21laG93IGFuZA0KPiB0aGVyZSBp
cyBubyBwbGFjZSB0byBzdG9yZSB0aGVtLiBUaGVzZSBhdHRyaWJ1dGVzIGFyZSBzaW1wbHkgbm90
DQo+IHN1cHBvcnRlZCBieSB0aGUgTGludXggTkZTIHNlcnZlci4NCg0KVG8gYmUgY2xlYXI6IHRo
ZXNlIGF0dHJpYnV0ZXMgYXJlIG5vdCBzdXBwb3J0ZWQgd2l0aGluIHRoZSBMaW51eA0KZmlsZXN5
c3RlbXMgdGhlbXNlbHZlcy4gTkZTRCBjb3VsZCBvZiBjb3Vyc2UgaGFuZGxlIHRoZXNlIGF0dHJp
YnV0ZXMsDQpidXQgdGhlcmUgaXMgc2ltcGx5IG5vIG1lY2hhbmlzbSB0byBtYWtlIHRoZW0gcGVy
c2lzdGVudCBvbiBMaW51eA0KZmlsZXN5c3RlbXMuDQoNCk5URlMgbWlnaHQgYmUgYW4gZXhjZXB0
aW9uIHRvIHRoYXQsIGJ1dCBJIGJlbGlldmUgTGludXggZG9lcyBub3QNCmFsbG93IG1vdW50ZWQg
TlRGUyBmaWxlc3lzdGVtcyB0byBiZSBtb2RpZmllZC4gU28gYWdhaW4sIG5vIHdheQ0KdG8gbWFr
ZSB0aG9zZSBhdHRyaWJ1dGVzIHBlcnNpc3RlbnQuDQoNCkJ1dCBJIGRvIHdvbmRlciBob3cgU2Ft
YmEgb24gTGludXggaGFuZGxlcyB0aGVzZSBndXlzLiBORlNEIHNob3VsZA0KZG8gc29tZXRoaW5n
IHRoYXQgZG9lc24ndCBjb25mbGljdCB3aXRoIHRoYXQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K
