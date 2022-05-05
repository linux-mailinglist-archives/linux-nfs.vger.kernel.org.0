Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C551B67D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbiEEDYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 May 2022 23:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbiEEDYA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 May 2022 23:24:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF2275
        for <linux-nfs@vger.kernel.org>; Wed,  4 May 2022 20:20:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2450UbZY029440;
        Thu, 5 May 2022 03:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zcRmAODF1gOXoluJb9IeiHPXrYV27eHrQzTw4tE4sr4=;
 b=Uw4Y7gkCoWu1e7IlAdZXJS6mKkSLKNZMvDJhnzh5K8rRBxlPWpnThQqaLqMX0wMFfOCA
 SbbqeReJnDE+VhT9Q1uxfJsD26rn1cgcJGt7Ab0DS7FWIGK3+oOHjWbNUhpFO05ZRSO7
 tk89uEpLFMUgojUBQt0FmQS9ZznUuHrBElj5z0ysT/L3WxPIAj90QXdBFksDT2wwlih9
 PpsCh5aqYgrwBAe499V8z2O0Wv0P1KL5nP7LLOIUhTwCuAJREtIG5EUy0Lv1ZXuCJdLM
 rzdYUQgSzOd01CyijQSeE99xO+BwFDFMHq+JoiDlmiiH6dtUtWSSgA5Q8xUiON1UMH7K Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0j794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 03:20:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2453EvqR008908;
        Thu, 5 May 2022 03:19:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruja60y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 03:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X33jU+/WbMIWLX+mvfxy0N+zKxXbd9KKKVE3aTQTQlDKb6gLXIEs0CkGtpcjkKxxc0lS1zHf0ZdOAz4BaVQIb71aEmjuwkvdGziAMyVL5rvh/hfM7xt3zEPKGxBHkeJndWeSWJOzfbtj7LJqSwkW24P9F0or0+SNC1n1Rjk8c0Q9PfEr4VrHgMyTc43JJfc0fLHytY9Zv7RHuGsiHk0zqFEe3IYG++VLJPlXeg6e1TfYYOJof5qqfLxedTUSzeG4fE+bxPfEzqpYERdKZRReyY9gI3Y1cGyE2e2CPlPEzzaHKK7IsIad3sumidLSRUzR54mXHZ0lIZhz3agBIAiitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcRmAODF1gOXoluJb9IeiHPXrYV27eHrQzTw4tE4sr4=;
 b=fKKPDE/4DAE7nsIBmKyu0Zq/YruQd2qimWEUESWMI5r5sDcFdB88vrRcDN7xelMaE4pMJgA4vThl3JujGGX5g92YQrRbcFc9s+8I0L7w5KxvSPaVL2RxfZ38ApmPFBzMOvHkEMRKT8nHl8RGw9F9sOl5IocLjnItOikIv+wXyeZFqVvn0u0JpgwLEzb0bALp89ihsqsrAXHH4ijOJEGt1TZr5eS8zm6NnvMC7bER/XIbE5iHsPRFypoOQTavqVncPmmt0HJt6fHXcAnY/ixSeSCvMR4M1QYSN2U26nnDER54v1Ecx6wFx52nnKJYvkhcPXG4jNSmimGUAwi+VCcBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcRmAODF1gOXoluJb9IeiHPXrYV27eHrQzTw4tE4sr4=;
 b=K7ly8aXHZLKBNRjhOjEfVahFYJq/rOCcrDaWaK8eLcpJZLzeBbJopQhqR3kxRTKEGMxEZQH/SsubCjNDmzAj1Z6Zg59IXdqpfFrYW2/rg3f4iGda2ioprmt+NbyUqdQDYgsgBZFONi8XvAi7qraFH5O2rdnGg0bqAbnJ68PMNbc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2512.namprd10.prod.outlook.com (2603:10b6:805:47::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 03:19:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 03:19:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Topic: [PATCH] SUNRPC: Don't disable preemption while calling
 svc_pool_for_cpu().
Thread-Index: AQHYX9vL0QvoWl04KkqOdhnLgfmokK0Pnkc+
Date:   Thu, 5 May 2022 03:19:57 +0000
Message-ID: <C4463E0E-2886-47A2-B915-A008C35343A5@oracle.com>
References: <YnK2ujabd2+oCrT/@linutronix.de>
In-Reply-To: <YnK2ujabd2+oCrT/@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dafc0201-2b42-47fa-6000-08da2e4621f0
x-ms-traffictypediagnostic: SN6PR10MB2512:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2512C087AB13D3DED27E748B93C29@SN6PR10MB2512.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dNnJuWHOe+g4GARoWolRiCCMBoyQGjhqRlOMlmGgvjdcnXuqb1xzWC9wxR6X6BzIy+OJhJsVmqOOxn2yAmJtYjJzQrL4bG741kwV6Y7SNNoMIcKdPP0NK84d5MKRIuuw6Fv+cuAww2htsoprmoNvxe541uircvz4AufooPyU43HiNAjLsqaW5nfdzHr0cF/Ul1K2Z/6i8t4+4M5k6Gb8NqIiImL/5pjJ75+v59/TnvJVSVhhJr1dSADAyCX11J8lm9PzM0Z3s44FA8l9+a5ogB8hm0M+d6Jy+nMhG08EoQPCeS019vcoudAiIIxs6oEvrF4qY/qBhkZKQCO3nEgXR/kMhZ5hn7ss7Q2ZCm6HKh6CX+RiZ0NvGce5tAKrK6lisf+R+FjZ+a90gMZ8+hAlaZd89vkvm2H5TPoXUx3wcNncMGBhuXuHliQMzkz9ao3GEI9zwc1ZrhRhv9T8MxJ/2xD9bSQhB4NeRB4AjgBKawUpFcHLwsGjS2ksIzAIDJrQsJXwdBhV/sSvMOEV2tAFG1X/GdFMIrCXysFEnhCyqSYFCoYr0nZVCayVNoeUmBQEUTlXSOeAgwwIlfvJDoLzjHdJFAhCuvhFHiBNJ1TsRZTnOonYXzML7AoDKWN5cQYPYcRqXkY544swziIrnfgcBsfjpo85w34Df+BJYBntMKiPL5ApnNe0MPEo4lgIXok0JdLo6/WkBKAP30TA9x1u/56CpeijCMe1vgkzs5swXZenj856D3WD9u5unGnVbY/e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(2616005)(6506007)(6916009)(54906003)(316002)(86362001)(6512007)(36756003)(53546011)(122000001)(186003)(38070700005)(38100700002)(2906002)(8676002)(76116006)(508600001)(91956017)(6486002)(66946007)(66476007)(66446008)(4326008)(64756008)(5660300002)(33656002)(8936002)(83380400001)(66556008)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0EvV0tsTitZQ0VrNkluV0h3NnRvVDBJdUg3Mm11SGRIYVRmS21FVVRveHRB?=
 =?utf-8?B?U3ZrVS93djQ3VVBMbWJWdDdwRUxuNFBKdEpGcG1TbzhBUW1kNy9QNGFId1ph?=
 =?utf-8?B?TWUvNGFHU3lxN3BpUkVVY0p5YlNuR1BUVUxkQ1JwdFVtUVc4dnpUcjN2bnVY?=
 =?utf-8?B?di8yTUYxeUV1UC9Pb1RCR2JjS2FvWG1CODExOE1nVWhYaXE2cVU1b1FtdUhv?=
 =?utf-8?B?NDJvek96dVFRUmxGak1zd2NoN3o5RmZDbXIzaTdsUm5WMVpkdHlyNGY4QXRa?=
 =?utf-8?B?T0svRVFUMENnOTNxbmRDNk44MHE0QmkvMmliWkJ3WGN5c3pBcENCeEVkVXRV?=
 =?utf-8?B?OERha3BxUENCaU9JUWZGNGdhclFlMjUwTlZPcjRuQ0VEZ0lWSVNoL1F1dUZn?=
 =?utf-8?B?ait6aisraUpuMjYyTzBXYjBEY3RRYjloWEIxM3lGS0kxaUQ0NHhYQkhRQ1pq?=
 =?utf-8?B?NTY1bVV0UGtrTkRncUhYc09pYUduMW45VzloUXZaNW1yeTgzNTFINk9UeEhY?=
 =?utf-8?B?MWpmMXFaUTZXdExyMmNOeUhrVGlJelpzSFR2cWV5M0NSWElzYXo3Z0MwWU9t?=
 =?utf-8?B?azJYZllRTFJ4UU1ZeS9kQmR3OTV0UUNpaXBFQ1FpMnBGb2FGTCt1blJtZGgw?=
 =?utf-8?B?ZWQ0d1g2WlBtSmhBSFVrQXNhc1ZVUGhmTk9xcWVRZkRYM1Q1MDdXeFBrLzcr?=
 =?utf-8?B?ZkdhTTZxd1ZmQXB1Uk9zZVdTRUdyNXNTVnNLeSttb1I3Z2VKZXdwanNQc0hJ?=
 =?utf-8?B?NlBhMCtQNUZMUWRFKzZQR1VjYlEwM1RISTJ0VVcwWTNjMVo1dVMycEFoQ3RE?=
 =?utf-8?B?TzVnVm1SU3JYb3kxSlFYbmxRSHNLV3ZSTGtjUG5URk1pY1V0cmJ3Z3p5SUpP?=
 =?utf-8?B?NHEvQjJ3QjFlTksvczVVWENtOXhUdzBLQncxbXRWcmZFMXNFblR3L2Z0L2VP?=
 =?utf-8?B?em5TY2t6QUpHclVJUFgyMHBaM1FUbFhLSzlISzRyU25jdnVNUHk3SkhIcjQ1?=
 =?utf-8?B?WHk4TXFLa2dHU1R3UVVwenlTa1I0YnhSdVUzVzJsMnJpakNHZDRrYkZvUWxx?=
 =?utf-8?B?TTNuRzRGb29FVlhrTmc2eXpLUzQwQ2VaR29lS3BhUXVVWnhwSlJRMWFqMCtI?=
 =?utf-8?B?TkNtR0luN2hKNnpRaWFBUHZxVy9hSlBtQmxaLzBlaG5ENmo1ZDI4UFl5TVo4?=
 =?utf-8?B?am5INCtJWXNYOUlSZXhuZExQdUpOb0FQdWFvS29oODAwd1JsRmZOcHZMVEF4?=
 =?utf-8?B?ZC8xYzRBZjhUMGpnTFJzclVSSklMSklrMkZFNTdjRGFjT1IrRVRYVjM5UERS?=
 =?utf-8?B?aWkzUmtVRnJXVXNDUkh3WXd1aXN1bW9yTnNxV1RxaXJ0Sk9CL2JpWFVndXNq?=
 =?utf-8?B?c2hXa0YvYmxrNnlRZ0gxck5GNk5YODhzMm41T0R1OFFEek1SWHNOcHdlMitu?=
 =?utf-8?B?R2JTSnF4djE5bENMbU1mbzM3Qk9BRGhwVC9zRldybjUyOFZHdnJ4WlFGeHB4?=
 =?utf-8?B?OVowdVNmMHJacXpoek9mRVBiOGRkUG10OUZUKytNNUozRklXK2ZnMmRWbDVJ?=
 =?utf-8?B?ci8zb1hYa0pFc0hHT2lQMU45Vi90RXlFNWJOcFRRSUp1dTYzd2p6djhRbkhT?=
 =?utf-8?B?K1pPRHhadXlNMGl0aUlYb2QySDZ6Mm84bk1YWU1IdWE3aC9sTEJiVzBKQzdu?=
 =?utf-8?B?dlA4WGJBQWtIc21rM0NMRURsZkVMaDh2eDZFK09NazlKUHlPSGtKS1JSQmRT?=
 =?utf-8?B?Z0lZbVcvdlpNU3JCSmYwUFZVZVpyRlJWTlljVDhZM29TTEdBZGQvS3FoM2ND?=
 =?utf-8?B?bmpCbHRMRU5rRG4vcWRoWHZCMGZjMS9ya0pBK3hsMUdoamx3ZjNCNkp5dTRN?=
 =?utf-8?B?Wkx1YS9FMVFzY0luU3M4R250bmx6UmxYVVlkT21pRVlINjhmT1ZmMWNYRUds?=
 =?utf-8?B?T2R6NCtBTVd1cnczeHpOMlFJSzlDcjNQWnRBZ2FuZitSMitTVzArT1lveENS?=
 =?utf-8?B?VWpJS0VMVDNBL3Y0VEdsamxZdnRrMHozSCszdm0zZ1VpVTFwdkp0N2tXTnRu?=
 =?utf-8?B?WHczME15ZkJweDlQcXVLWWhwaXNvUmJIQkxWdWFqSGJwVlRFLzlFUThOdDU0?=
 =?utf-8?B?TlBEdm5qb01YbTJCaXlxb2k2STFnT2R4NVovS3NBVllBV255Rk1nT3JDU0Zl?=
 =?utf-8?B?M2dBckhkUittQjNQSGJaNERwdERiYk9qdzFRejI1M1pGK2t6bW1GdEdaQWla?=
 =?utf-8?B?NVIrdzRGNXM1RFlsOS9oSy9zdkFVU3c0bVR2Ui9hdlpISWlNK2dUdTdCRkpG?=
 =?utf-8?B?b2NkVWVOQ1dBNS9KRGRrOGZqTVByZHhzcHh6R0NyNGRlWHZSNlM1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafc0201-2b42-47fa-6000-08da2e4621f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 03:19:57.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+pJgbfX5U3bVpg1n115xURERAvdXqzxWSQUotzlYFhxIOzni/IbO7QDLEzIPn1mW63SmlaNpRTKf7S70MKHTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2512
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_06:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050022
X-Proofpoint-ORIG-GUID: 0BlzayFPxdHEDuO0GS0cxeV7lD7LpAbL
X-Proofpoint-GUID: 0BlzayFPxdHEDuO0GS0cxeV7lD7LpAbL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQpPbiBNYXkgNCwgMjAyMiwgYXQgMTA6MjQgQU0sIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Ig
PGJpZ2Vhc3lAbGludXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiDvu79zdmNfeHBydF9lbnF1ZXVl
KCkgZGlzYWJsZXMgcHJlZW1wdGlvbiB2aWEgZ2V0X2NwdSgpIGFuZCB0aGVuIGFza3MgZm9yIGEN
Cj4gcG9vbCBvZiBhIHNwZWNpZmljIENQVSAoY3VycmVudCkgdmlhIHN2Y19wb29sX2Zvcl9jcHUo
KS4NCj4gV2l0aCBkaXNhYmxlZCBwcmVlbXB0aW9uIGl0IGFjcXVpcmVzIHN2Y19wb29sOjpzcF9s
b2NrLCBhIHNwaW5sb2NrX3QsDQo+IHdoaWNoIGlzIGEgc2xlZXBpbmcgbG9jayBvbiBQUkVFTVBU
X1JUIGFuZCBjYW4ndCBiZSBhY3F1aXJlZCB3aXRoDQo+IGRpc2FibGVkIHByZWVtcHRpb24uDQo+
IA0KPiBEaXNhYmxpbmcgcHJlZW1wdGlvbiBpcyBub3QgcmVxdWlyZWQgaGVyZS4gVGhlIHBvb2wg
aXMgcHJvdGVjdGVkIHdpdGggYQ0KPiBsb2NrIHNvIHRoZSBmb2xsb3dpbmcgbGlzdCBhY2Nlc3Mg
aXMgc2FmZSBldmVuIGNyb3NzLUNQVS4gVGhlIGZvbGxvd2luZw0KPiBpdGVyYXRpb24gdGhyb3Vn
aCBzdmNfcG9vbDo6c3BfYWxsX3RocmVhZHMgaXMgdW5kZXIgUkNVLXJlYWRsb2NrIGFuZA0KPiBy
ZW1haW5pbmcgb3BlcmF0aW9ucyB3aXRoaW4gdGhlIGxvb3AgYXJlIGF0b21pYyBhbmQgZG8gbm90
IHJlbHkgb24NCj4gZGlzYWJsZWQtcHJlZW1wdGlvbi4NCj4gDQo+IFVzZSByYXdfc21wX3Byb2Nl
c3Nvcl9pZCgpIGFzIHRoZSBhcmd1bWVudCBmb3IgdGhlIHJlcXVlc3RlZCBDUFUgaW4NCj4gc3Zj
X3Bvb2xfZm9yX2NwdSgpLg0KPiANCj4gUmVwb3J0ZWQtYnk6IE1pa2UgR2FsYnJhaXRoIDx1bWd3
YW5ha2lrYnV0aUBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGlhbiBBbmRyemVq
IFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCg0KU2ViYXN0aWFuLCBJIHdpbGwgaGF2
ZSBhIGNsb3NlciBsb29rIGluIGEgZmV3IGRheXMuIE1lYW53aGlsZSwgaWYgSeKAmW0gcmVhZGlu
ZyB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gcmlnaHQsIHRoaXMgaXMgYSBidWcgZml4LiBXYXMgdGhl
cmUgYSBsb2NrZGVwIHNwbGF0IChpZSwgaG93IGRpZCB5b3UgZmluZCB0aGlzIGlzc3VlKT8gRG9l
cyBpdCBiZWxvbmcgaW4gNS4xOC1yYz8gU2hvdWxkIGl0IGhhdmUgYSBGaXhlczogdGFnPw0KDQoN
Cj4gLS0tDQo+IG5ldC9zdW5ycGMvc3ZjX3hwcnQuYyB8IDUgKy0tLS0NCj4gMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25l
dC9zdW5ycGMvc3ZjX3hwcnQuYyBiL25ldC9zdW5ycGMvc3ZjX3hwcnQuYw0KPiBpbmRleCA1YjU5
ZTIxMDM1MjZlLi43OTk2NWRlZWM1YjEyIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3N2Y194
cHJ0LmMNCj4gKysrIGIvbmV0L3N1bnJwYy9zdmNfeHBydC5jDQo+IEBAIC00NDgsNyArNDQ4LDYg
QEAgdm9pZCBzdmNfeHBydF9lbnF1ZXVlKHN0cnVjdCBzdmNfeHBydCAqeHBydCkNCj4gew0KPiAg
ICBzdHJ1Y3Qgc3ZjX3Bvb2wgKnBvb2w7DQo+ICAgIHN0cnVjdCBzdmNfcnFzdCAgICAqcnFzdHAg
PSBOVUxMOw0KPiAtICAgIGludCBjcHU7DQo+IA0KPiAgICBpZiAoIXN2Y194cHJ0X3JlYWR5KHhw
cnQpKQ0KPiAgICAgICAgcmV0dXJuOw0KPiBAQCAtNDYxLDggKzQ2MCw3IEBAIHZvaWQgc3ZjX3hw
cnRfZW5xdWV1ZShzdHJ1Y3Qgc3ZjX3hwcnQgKnhwcnQpDQo+ICAgIGlmICh0ZXN0X2FuZF9zZXRf
Yml0KFhQVF9CVVNZLCAmeHBydC0+eHB0X2ZsYWdzKSkNCj4gICAgICAgIHJldHVybjsNCj4gDQo+
IC0gICAgY3B1ID0gZ2V0X2NwdSgpOw0KPiAtICAgIHBvb2wgPSBzdmNfcG9vbF9mb3JfY3B1KHhw
cnQtPnhwdF9zZXJ2ZXIsIGNwdSk7DQo+ICsgICAgcG9vbCA9IHN2Y19wb29sX2Zvcl9jcHUoeHBy
dC0+eHB0X3NlcnZlciwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSk7DQo+IA0KPiAgICBhdG9taWNf
bG9uZ19pbmMoJnBvb2wtPnNwX3N0YXRzLnBhY2tldHMpOw0KPiANCj4gQEAgLTQ4NSw3ICs0ODMs
NiBAQCB2b2lkIHN2Y194cHJ0X2VucXVldWUoc3RydWN0IHN2Y194cHJ0ICp4cHJ0KQ0KPiAgICBy
cXN0cCA9IE5VTEw7DQo+IG91dF91bmxvY2s6DQo+ICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPiAt
ICAgIHB1dF9jcHUoKTsNCj4gICAgdHJhY2Vfc3ZjX3hwcnRfZW5xdWV1ZSh4cHJ0LCBycXN0cCk7
DQo+IH0NCj4gRVhQT1JUX1NZTUJPTF9HUEwoc3ZjX3hwcnRfZW5xdWV1ZSk7DQo+IC0tIA0KPiAy
LjM2LjANCj4gDQo=
