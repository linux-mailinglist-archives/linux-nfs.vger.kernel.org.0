Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1225A787912
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbjHXUGH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243413AbjHXUGC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 16:06:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D1D170F
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 13:06:00 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEYqh027013;
        Thu, 24 Aug 2023 20:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PddFaPQ8EPEFcUEr4/Iqz1N7RzmZYdwmQe2nqLf8VUQ=;
 b=2jlmRoJAkh0uHbySgFjuJF/YlqnnajiCqh8LpmN3UIRfRByDGjltOh7q82ps9zLkfPpt
 YgUPKEZkLO/cKelZBBaUKnYqBOJ+2RevTHZ+/rxCzplbGNPyzXj4Hin9IkthuYaNAIx0
 kKe0P9u/QCi2T4N1bkQn1e94ffTx2ifztZyPJ1uGU13c/yQY5E+Jhbo/ZE17AjVNtHPz
 T7PINm0gxq0Cih4ftu1qKOwZK+bufxqvyVlXCQT7HZ0/JAtZPsqGO6rSRo1eSqAbXBdz
 1gGeTOnxYeIhjpMk48DAjp058dzIMQFlyKCmMfCTj86wX2LVkvXVXey+/PLv8/u5cNnH jQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20dcydm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 20:05:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJtkjq035774;
        Thu, 24 Aug 2023 20:05:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ypwvfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 20:05:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TccFnB9sv24hcOyzIDJ/B2phat0T3ZeHVGwyOT/GZADnvhX82QEUkag6KwaCd4m+/2PmqPbfwvy02trvRBdPXf9baSx3jkVi+WpCjnBG1Edn6fqFOwk/411mHH+PKIxrTh6uhqN0f1fs0w7z1fnC15McZYOEejqAC8dOkVSm/EKf4CkI0sZDDuQh0mhDn0q4SEWUPARs0ad2H9iZpoAXeAtq/GL/SbpvrappL04ouQiZTVK/UEGy1YKUKgCCmqodw1bM0Onv4KXspgqhTfvKHo6jfaC2EiCEPElO8ASCu/o705/MRaOe//4gLjHEruzsIkr3QhpIkJpozbT9/jqIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PddFaPQ8EPEFcUEr4/Iqz1N7RzmZYdwmQe2nqLf8VUQ=;
 b=Xif4UtRcH2fS8PJZZx1azYn05/AeJBr6UMGh9RzzCfXdDadHxL8Tf6tIFr5nY2mcZMwLGluF+imZ5kracw3dv4+G5OYrRfnEpt+TbRLossoWWahpoXc1FDmeb9khD5HyR2PwrsGWcxFvVgeVES8Q617fbROIqYMYVeSQxonmUZffzN5ZBXHVLwdkT3AOgqT8JwXtcrpWUqVBc9oyp1k/+4xeIQG2ZZZC21J50GaVnlMt2EAqyHJiTF+Z2zhbdaVMrWmMda2LZX1BLfmWkDLkSyZuwgcSTRfiqT0AqoQzP5Ho7HTKKFif2JEA64RBbjEIaW2MqnmP+kdggSfC73pyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PddFaPQ8EPEFcUEr4/Iqz1N7RzmZYdwmQe2nqLf8VUQ=;
 b=gwOFDRoSR/oU8bjRgV/iRRcjzIThW7aTJzhyZb2MVxS2vKHSrZj0Y99hB+HJEVgvE+vDpMgeNK3btkt71/NVKStqAzywdwXouXuPawN9457NRtFjoK2JmCtyPu4h4jNQsfE0NbYQMV7SZC/daRTr6SrQUBuJceoBt8jORtIdCBM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 20:05:36 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::40f2:46bd:814d:297e%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 20:05:36 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Topic: [PATCH v2 1/1] nfs42: client needs to update file mode after
 ALLOCATE op
Thread-Index: AQHZ1qM3nsz9B9LdTESrYb5y9fzFrq/5m0oAgAAC7ACAAAZZgIAAAPiAgAAitwCAAAVWAIAAEdcb
Date:   Thu, 24 Aug 2023 20:05:36 +0000
Message-ID: <F88C0F0D-62EB-45A2-8C70-477CD13D6EBF@oracle.com>
References: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
         <c02190c39f123a16aeae70fd65a68fba4aa70b6f.camel@hammerspace.com>
         <067a68e1-cd7a-55c5-619b-d64266b5ada9@oracle.com>
         <af94f54e27b14e3129691d78ae1f439b33fb7733.camel@hammerspace.com>
         <24ae5b14-0fe3-15e8-37e8-e8aed0cdefa9@oracle.com>
         <5b0bc635-40bb-2c3e-28dd-b9a71814a7bb@oracle.com>
 <737abceb902411f583f731108fbc7eb235120eaf.camel@hammerspace.com>
In-Reply-To: <737abceb902411f583f731108fbc7eb235120eaf.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4257:EE_|PH0PR10MB5706:EE_
x-ms-office365-filtering-correlation-id: 1ad95b0d-f98c-4665-c98f-08dba4dd7b5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qskQPxqj2ls8Q0yXpPEVAS2O3KbFWOPxHw+DmtHz4lzBZy47gu3lC7htz5pThWkrefPGYz4PmKcQ+9BUMh0f2tDgtriQKpl05XpP7g65wLP7x4dbV2i+2Kif6deedDQ1cX8mRsaZ0RRcxf3skl78dgD8lRspctaR448vzAUoOk/83QKyJazi5UqFiwMVLQ9I0UQIyjsgzwBB5/VLOAX9nVy40vF49ZLMFCo1jUJPHlJSWPXL+wE1tVvF8idti1kEXdEF5kX8vXSraWIdPYlC4WhXerTvnKs2T5njsLEzu2BDrIS2zjMqUPXCUAV0Ry+my41x4XAA69bOIMrY4MG1xRH00g2oyT50QC8oL4x7w8UfPVfLhWJTAnhVuWTkkZyVn180O1erByY3+BkEvTMNqMKoUI9ECLdyBV+VAjlvgkwbNrq5X7bY69NiePho2uRDhwmIgviCtmLcPfziSSQDzIxDPHIoyfeXMeRDaxnXXgWHa3zQyVCsUOPwaxUo885Bd6BBWPQ3/UDymcO8Iqp5ErSjJ6oUIVmFCLlDsCNL5nSQI4rjV2zM8gsZ4x9mDpNNJzDtPHYK8oGVDSF2oI3JNOGZtUwn5H/cXtEe5iefyRdoWTGZr/WGjBWE+1ydjEjaBXdJuOa9rTMtY/pU/fATZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199024)(186009)(1800799009)(83380400001)(4326008)(8676002)(8936002)(2906002)(15650500001)(6916009)(316002)(44832011)(5660300002)(41300700001)(122000001)(66446008)(64756008)(66476007)(76116006)(66946007)(66556008)(38070700005)(54906003)(86362001)(6486002)(2616005)(6506007)(53546011)(33656002)(478600001)(71200400001)(38100700002)(6512007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG5PRlR6UWk4amRXd01IWGlOd1BxQjc4QXh5UXpWUXhhU0RBRjNuWWN1UWt1?=
 =?utf-8?B?NnU3c2R4R1R0ZVU0eVdnQ21SRGdHTm03MUl2R2F6cTUxUm1pdE1FS0dTem9u?=
 =?utf-8?B?NzA3RWRLaXMxNjJNMHEwK3NQcER5QUo4NHdwb1EvbGRHS1RMQWdxV0RIdTNV?=
 =?utf-8?B?elNYcGtXbXJYWGhrZHlJL1dCYldVMTJiN2NuMFl6NFl5cVd6RzZwdC91SVI5?=
 =?utf-8?B?aUR2bERIN1BDOFdMclpGZFBoSzRUM282RU80N09SQzh3VHVMNmFURmhuMU43?=
 =?utf-8?B?VmVSTzAycDVRVnRBcDNqbVVoNnBkVWVoNFV6ZmpqdVp4N0NTaEJBSHRHV2pa?=
 =?utf-8?B?NnplSTYzb2ZTdEFxQjRIS1FjVEF0QjJxZHY4cC9VRjlOOFFHZkRCWmwxTmli?=
 =?utf-8?B?NDFVWTlwWGJzbzVlYVIva05HajREVWYxR0tZck1YRzJCZER2RS9qOFE5dXUz?=
 =?utf-8?B?MWMxY1RaaDVZRlpGVExxUHF6b2czc0hPSGIxRmNqWnN6UjRTRDE3a04wVGFw?=
 =?utf-8?B?cGJsWmpxSkRZTk9kZkRqcFNDNXZFakNmOVVpSk9LV0pDTjZWWXpjaHJYSmFF?=
 =?utf-8?B?NWIzSi9rTHhib2lQc256SGhMYTFPMTc2Nm44UER6b2J6Z3Y3ZjBjYXppdlNB?=
 =?utf-8?B?MmlBakNjdlBiODQzOExvaVpUUUdLazZ4dkc5aHlzNzlhU3paSUFvQUVQV1Uy?=
 =?utf-8?B?b2UvcU94bTRVVk5HMzZ3NjAzUGloQlJlN2J6YzVWVFg0UFg0RHR3VllPWTFD?=
 =?utf-8?B?M0MydkpHUTJSOW53RXpYZllCK3I1ekRWUnlUT294NHpYTTkvZ3J4THYzQ1Vw?=
 =?utf-8?B?Q3RYTXFnMjlwWmdiT2c4QW1vaGZZRnhGaTRuUXNGT2ZSbUI1L01BczJmSFo1?=
 =?utf-8?B?cytjMEppMTBBRE9IcjVFWmNJMDNUVkFMb3hqODIzNTZ6TVJjNkJ1S28vemlC?=
 =?utf-8?B?NHNRQmg2Z2VMQXMrMkR2NHRMZHJka2x4RkxmejQyWVQ0WnMzKzRhR3JYbmpY?=
 =?utf-8?B?YlUwVDgvNXVOdmZwNEpPOWl6MmVJc2FNWjZGbVY4MTZDcUx1YlNLa2ZxTGxj?=
 =?utf-8?B?K0hjeTJreGU3TDZKWm1XYVV4YVNPQXhEcFZ2K2V1bkhaQ1I3TmNkdEpMd2xE?=
 =?utf-8?B?WlhaczZLaXZnZ1Q3N0RhbXJOTnBaaGs2TVBXVHYwMEhDNXVnVzYwWWFqUk5D?=
 =?utf-8?B?WnJ0Vm5vdTF0NE1uWXFHVTR0VTlCaWtjY0RabVU4SXhaeTYxTGYxRjRkZkta?=
 =?utf-8?B?NzYzSExUK1NBbDViMjVobFgxYlYwWFpoaTdKSk82bmthYTRKd3luR0k5bkNQ?=
 =?utf-8?B?TkZiWEU1MjhxcktHUkhpSTR3TVc0OXZyR3N1WjdxZmR2Z2NGYmVWOXRSL0ty?=
 =?utf-8?B?ZmFjSzdqazZoOWd2clJraERhK0hJUzFXMFpuRlR4RnVYUk9MdFlobGxaMVBs?=
 =?utf-8?B?QUVtc1BjZkhRUGZTOVFzbUtkN0hzWWlFeGp3OTVRcEo0SFhLSHc0dlF0RU5k?=
 =?utf-8?B?YmM5L2FDbTFJbm9LS0xUcXFmVXRDSE5UMlZWWUpCUDlQL3h2bXdSbmFqT1Ft?=
 =?utf-8?B?Vk55UmRMajBUS1NlTVJqWmI4Y1JGaGYrRy9mWDZmdXNpMURxSUM2eGVXckFn?=
 =?utf-8?B?cWE2ditycnBJRFRiZFhrL2VxQ01tejdZMEhsMEZGdUZITTlhQmVFZUkzQjVL?=
 =?utf-8?B?aHc3UHo5SGpYdUh2S0oxYlBoSk1JQVoxTWI0cU8yOVdYVDRrWUVIQkc0T0J3?=
 =?utf-8?B?SHMyUnE1dlB3cTJyN1ZCam5jZHprTDJjUndqaHBsMHpYRUw4VkRRcnZnenVw?=
 =?utf-8?B?bDlvdGpLZHBua0dlN213UjRrekM5dmZYek91cFhZaFo1QW1lc1F2RFVkUzh4?=
 =?utf-8?B?eFRIUzc2T2FmSHRUS1N0WDYyNWYyK1UzQ1BRR0hFVlpSRzlJS1kxQ2lPOXp2?=
 =?utf-8?B?S2Y3cFc2NnpWZUhtQzR2cEpWNy9tcXpuTjFBVm9NY1I5M2pWVVduQXhLOXBI?=
 =?utf-8?B?cG44T09GQXdHTnNRZjRmQWtkU2xOU3BqeHlRS2syclhPcnhrNGNRVHpRdkJZ?=
 =?utf-8?B?U3RGUEd0VzFIZHpQYzVwdEZsYzVhY2N0eW5jQjRJYklsMCswMFFZamFXRlJs?=
 =?utf-8?Q?CkZ9xct6He6ApfPczyoWeNPq0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oPx5fgtOTx/Slspfa9gxL964YKpQ55gunk9CdWY5tu5zVou1bomsNFDroOLTeGz2gQ0VL+PYMqRifVvc3ONgRs6ZyOxy0DV1xtAs4UzV3IXXWLkKmT4RpNzzGB9+YNb3PYA6tEGr42OqG3L8XotbzZa1e3UEAGSq1QWhQLaz/UyMO2F1ruTJE4VHco0NRPOJAD9mVi/tVmtjnsZPs0tq+bKv5Y9nd/rAR7LrI5ySrxgXJeyKG5MRyf7i1QUE0vnyrZokJFgptfpLb4xT5YrGg2oE3GQ8bGQZZR+FlfCi55NjznWbP2jMTkV7RCq5VoxIU6SBJ7itavJZ9ENxZPkJcSgq2X2rKpVx0cfUI2z/xwFy9bVV7AwLRR6kqJ9hVLzI1W0b+jyrUp0pNlwGxVO2e0ZY0955x9kG8HrZ6CDbfMLkJeDvN1AXqhg5wxZF+odRQfOBxrQnSVmXPvO/eIRgzDR4PLFsPSanUkHRE7Ye0LAhnThrBSGB8+ygg1R2F26r50PLDCQC7OC0Z2HLFeRxdnwCZ6o4Xil/bcDBRiXnncOhwTZW9/zsTa8YvfvVDFb+u3wx0RIEp7fL7DfVFIAPWzc6ptUNofACF0wCqoPg5TAnn52M6fJeWo2of/4DCl2Ne+pKWJ60SHAZEMVuyB3QAPyrhAU2WKqbtIr7gCx3PDukhmhH476pq2zgynKMb3Ipa8qxXTr0ltAzGuyPMEzXQ0J94t+JMfwf1ifGZ1UY8CTbp7STvTnm+mCY2ssiJg6QB4AzpnareIvtVJtt9fQsoG2PE8sUlhsk5KMxou2HYfvScaLXOPTRDwGNgc39BASvFU45sUwDY9MJ8SlyDgUhsA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad95b0d-f98c-4665-c98f-08dba4dd7b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 20:05:36.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGfFxmddHYhDhXNVNrAQ25C+LUjK+oylfDPK1zaY8rAuABZhO3BJbppk74LcWAy+ae6s6QNJI9CyMnBqJULb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_16,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240174
X-Proofpoint-GUID: mIgjKwcO42SJXjdwsEkByjsMrvZDrKeJ
X-Proofpoint-ORIG-GUID: mIgjKwcO42SJXjdwsEkByjsMrvZDrKeJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gQXVnIDI0LCAyMDIzLCBhdCAxMjowMSBQTSwgVHJvbmQgTXlrbGVidXN0IDx0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUaHUsIDIwMjMtMDgtMjQg
YXQgMTE6NDIgLTA3MDAsIGRhaS5uZ29Ab3JhY2xlLmNvbSB3cm90ZToNCj4+IA0KPj4+IE9uIDgv
MjQvMjMgOTozOCBBTSwgZGFpLm5nb0BvcmFjbGUuY29tIHdyb3RlOg0KPj4+IA0KPj4+IE9uIDgv
MjQvMjMgOTozNCBBTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPj4+PiBPbiBUaHUsIDIwMjMt
MDgtMjQgYXQgMDk6MTIgLTA3MDAsIGRhaS5uZ29Ab3JhY2xlLmNvbSB3cm90ZToNCj4+Pj4+IE9u
IDgvMjQvMjMgOTowMSBBTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPj4+Pj4+IE9uIFRodSwg
MjAyMy0wOC0yNCBhdCAwODo1MyAtMDcwMCwgRGFpIE5nbyB3cm90ZToNCj4+Pj4+Pj4gVGhlIExp
bnV4IE5GUyBzZXJ2ZXIgc3RyaXBzIHRoZSBTVUlEIGFuZCBTR0lEIGZyb20gdGhlIGZpbGUNCj4+
Pj4+Pj4gbW9kZQ0KPj4+Pj4+PiBvbiBBTExPQ0FURSBvcC4gVGhlIEdFVEFUVFIgb3AgaW4gdGhl
IEFMTE9DQVRFIGNvbXBvdW5kDQo+Pj4+Pj4+IG5lZWRzIHRvDQo+Pj4+Pj4+IHJlcXVlc3QgdGhl
IGZpbGUgbW9kZSBmcm9tIHRoZSBzZXJ2ZXIgdG8gdXBkYXRlIGl0cyBmaWxlDQo+Pj4+Pj4+IG1v
ZGUgaW4NCj4+Pj4+Pj4gY2FzZSB0aGUgU1VJRC9TR1VJIGJpdCB3ZXJlIHN0cmlwcGVkLg0KPj4+
Pj4+PiANCj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29t
Pg0KPj4+Pj4+PiAtLS0NCj4+Pj4+Pj4gICAgZnMvbmZzL25mczQycHJvYy5jIHwgMiArLQ0KPj4+
Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJwcm9jLmMgYi9mcy9uZnMv
bmZzNDJwcm9jLmMNCj4+Pj4+Pj4gaW5kZXggNjM4MDJkMTk1NTU2Li5kM2QwNTAxNzE4MjIgMTAw
NjQ0DQo+Pj4+Pj4+IC0tLSBhL2ZzL25mcy9uZnM0MnByb2MuYw0KPj4+Pj4+PiArKysgYi9mcy9u
ZnMvbmZzNDJwcm9jLmMNCj4+Pj4+Pj4gQEAgLTcwLDcgKzcwLDcgQEAgc3RhdGljIGludCBfbmZz
NDJfcHJvY19mYWxsb2NhdGUoc3RydWN0DQo+Pj4+Pj4+IHJwY19tZXNzYWdlDQo+Pj4+Pj4+ICpt
c2csIHN0cnVjdCBmaWxlICpmaWxlcCwNCj4+Pj4+Pj4gICAgICAgICAgIH0NCj4+Pj4+Pj4gICAg
ICAgICAgICAgIG5mczRfYml0bWFza19zZXQoYml0bWFzaywgc2VydmVyLQ0KPj4+Pj4+Pj4gY2Fj
aGVfY29uc2lzdGVuY3lfYml0bWFzaywNCj4+Pj4+Pj4gaW5vZGUsDQo+Pj4+Pj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICBORlNfSU5PX0lOVkFMSURfQkxPQ0tTKTsNCj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgTkZTX0lOT19JTlZBTElEX0JMT0NLUyB8DQo+Pj4+Pj4+IE5GU19J
Tk9fSU5WQUxJRF9NT0RFKTsNCj4+Pj4+Pj4gICAgICAgICAgICAgIHJlcy5mYWxsb2NfZmF0dHIg
PSBuZnNfYWxsb2NfZmF0dHIoKTsNCj4+Pj4+Pj4gICAgICAgICAgIGlmICghcmVzLmZhbGxvY19m
YXR0cikNCj4+Pj4+PiBBY3R1YWxseS4uLiBXYWl0Li4uIFdoeSBpc24ndCB0aGUgZXhpc3Rpbmcg
Y29kZSBzdWZmaWNpZW50Pw0KPj4+Pj4+IA0KPj4+Pj4+ICAgICAgICAgICBzdGF0dXMgPSBuZnM0
X2NhbGxfc3luYyhzZXJ2ZXItPmNsaWVudCwgc2VydmVyLA0KPj4+Pj4+IG1zZywNCj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFyZ3Muc2VxX2FyZ3MsDQo+Pj4+Pj4g
JnJlcy5zZXFfcmVzLCAwKTsNCj4+Pj4+PiAgICAgICAgICAgaWYgKHN0YXR1cyA9PSAwKSB7DQo+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgaWYgKG5mc19zaG91bGRfcmVtb3ZlX3N1aWQoaW5vZGUp
KSB7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2soJmlub2RlLT5p
X2xvY2spOw0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgbmZzX3NldF9jYWNoZV9p
bnZhbGlkKGlub2RlLA0KPj4+Pj4+IE5GU19JTk9fSU5WQUxJRF9NT0RFKTsNCj4+Pj4+PiBzcGlu
X3VubG9jaygmaW5vZGUtPmlfbG9jayk7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgfQ0KPj4+
Pj4+ICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9DQo+Pj4+Pj4gbmZzX3Bvc3Rfb3BfdXBkYXRl
X2lub2RlX2ZvcmNlX3djYyhpbm9kZSwNCj4+Pj4+PiByZXMuZmFsbG9jX2ZhdHRyKTsNCj4+Pj4+
PiAgICAgICAgICAgfQ0KPj4+Pj4+IA0KPj4+Pj4+IFdlIGV4cGxpY2l0bHkgY2hlY2sgZm9yIFNV
SUQgYml0cywgYW5kIGludmFsaWRhdGUgdGhlIG1vZGUgaWYNCj4+Pj4+PiB0aGV5DQo+Pj4+Pj4g
YXJlDQo+Pj4+Pj4gc2V0Lg0KPj4+Pj4gbmZzX3NldF9jYWNoZV9pbnZhbGlkIGNoZWNrcyBmb3Ig
ZGVsZWdhdGlvbiBhbmQgY2xlYXJzIHRoZQ0KPj4+Pj4gTkZTX0lOT19JTlZBTElEX01PREUuDQo+
Pj4+PiANCj4+Pj4gT2guIFRoYXQganVzdCBtZWFucyB3ZSBuZWVkIHRvIGFkZCBORlNfSU5PX1JF
VkFMX0ZPUkNFRCwgc28gbGV0J3MNCj4+Pj4gcmF0aGVyIGRvIHRoYXQuDQo+Pj4gDQo+Pj4gb2ss
IEknbGwgY3JlYXRlIGEgbmV3IHBhdGNoIGFuZCB0ZXN0IGl0Lg0KPj4gDQo+PiBUaGlzIGlzIHRo
ZSBuZXcgcGF0Y2g6DQo+PiANCj4+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJwcm9jLmMgYi9m
cy9uZnMvbmZzNDJwcm9jLmMNCj4+IGluZGV4IDYzODAyZDE5NTU1Ni4uZWExOTkxZTM5M2UyIDEw
MDY0NA0KPj4gLS0tIGEvZnMvbmZzL25mczQycHJvYy5jDQo+PiArKysgYi9mcy9uZnMvbmZzNDJw
cm9jLmMNCj4+IEBAIC04MSw3ICs4MSw3IEBAIHN0YXRpYyBpbnQgX25mczQyX3Byb2NfZmFsbG9j
YXRlKHN0cnVjdCBycGNfbWVzc2FnZQ0KPj4gKm1zZywgc3RydWN0IGZpbGUgKmZpbGVwLA0KPj4g
ICAgICAgICBpZiAoc3RhdHVzID09IDApIHsNCj4+ICAgICAgICAgICAgICAgICBpZiAobmZzX3No
b3VsZF9yZW1vdmVfc3VpZChpbm9kZSkpIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHNw
aW5fbG9jaygmaW5vZGUtPmlfbG9jayk7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBuZnNf
c2V0X2NhY2hlX2ludmFsaWQoaW5vZGUsDQo+PiBORlNfSU5PX0lOVkFMSURfTU9ERSk7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBuZnNfc2V0X2NhY2hlX2ludmFsaWQoaW5vZGUsDQo+PiBO
RlNfSU5PX1JFVkFMX0ZPUkNFRCk7DQo+IA0KPiBOby4gVGhlIGFib3ZlIG5lZWRzIHRvIGFkZCBO
RlNfSU5PX1JFVkFMX0ZPUkNFRC4NCj4gDQo+IElPVzogDQo+ICAgIG5mc19zZXRfY2FjaGVfaW52
YWxpZChpbm9kZSwgTkZTX0lOT19JTlZBTElEX01PREUgfCBORlNfSU5PX1JFVkFMX0ZPUkNFRCk7
DQpPaywgSeKAmWxsIHRyeSBhZ2Fpbi4NCg0KVGhhbmtzLA0KLURhaQ0KPiANCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZpbm9kZS0+aV9sb2NrKTsNCj4+ICAgICAgICAg
ICAgICAgICB9DQo+PiAgICAgICAgICAgICAgICAgc3RhdHVzID0gbmZzX3Bvc3Rfb3BfdXBkYXRl
X2lub2RlX2ZvcmNlX3djYyhpbm9kZSwNCj4gDQo+IC0tIA0KPiBUcm9uZCBNeWtsZWJ1c3QNCj4g
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KPiB0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tDQo+IA0KPiANCg==
