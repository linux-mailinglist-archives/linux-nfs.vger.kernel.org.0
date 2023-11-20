Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D577F1CFC
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKTS6O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTS6N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:58:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D5C8
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:58:10 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKInfuo011396;
        Mon, 20 Nov 2023 18:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MEk23Qh1QxXwgCzrNF9gTH4ZudPMEn2UtlQJmKqQYDI=;
 b=wH+94aaiwv2BgudSYYmTYQbK2jB6/1iInFNpHGhT4SBU3Xya8BZMVu22EmoAzxdAoRLg
 VypD0AO3Jt7wUOMrcQIifoGXT/WBVIfBWzNPRDVPIGk5aVTed8pkT/RdI7zFBysvsGYR
 dKvUSHWssM+BYh85DrmR7kYFd65/dOwClEqQrSw6tyhUK3wLQNRxFxK4n3scPCs6dQFo
 N8IJBwjwWl3uK0f63HWahxvwqOjAd/2T++AKvgmKkMn5gqD4k98RDvEHe32tEBD7Hb7+
 1x1iQKTKVGypfySjzLaP95yKkZ3fRO/uy2Pz549QD/D6lunEGMMFzRZ5ptQEaqB2V0zW iQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvbcrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:58:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKICqdK037460;
        Mon, 20 Nov 2023 18:58:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5tg30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjqYy5PUt76R5SnMNZTyVSmd5McitT5B1LpHGRxk9tqLfWDbCoJnuLDYlDX9QquhezRmVYk8UigWHo/rQHi5hExvm+v/Cjj2O7E1XAAGziXvcAz2o5dMzf8dhMD4MfPvAfrfaXo69FW4oCaZrdhlkfLoS9K2T1oNhfYmtYbqzl3CtDsc0VknJeQ4dhCIygwAYNwJbpZlFcptrW33gR/7QK8qDHTVLZsv2Nm3GxIMzFtLDldCTAjSljblw5KwgXc+fMXNdy+LZb52Li4PzdjWSgM7f5hkFPo2Bb6JJjQ5effOY3/jltCxsuBs4v1GpYN/cTwBez+klO69aaffU66p8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEk23Qh1QxXwgCzrNF9gTH4ZudPMEn2UtlQJmKqQYDI=;
 b=E6U1jVTflcmYXNx8yI3z5Z+YtYWdfLgXz3EsXZ8/fdT8hHoyMhNrNaFb/8mFvY/P4fnvXrb5HMy6oKLFU1PIW6fQktStB1x3REaG7o4dpkDEmod9rMTQTS6l27YIt4FUzXUqUA0IGeHbhsmqDLvN5OvMFB2pZnYMvWIYp7emA2GiT4hOFrENmYUv7qzcC1XidMh+AGdA+f1VezUafy6ksYfYJJ8zjIlO0+RVll1i4HPvw9spZvn2511hXQk3WlltBW83BTBT4Tc9GBKIRn2WBlBZZ2p4qg5W6J4WgX0RhB/zMOPiAwsmbwtQd1H5KlQ/eNYA3hcQNwd0vih2kPul7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEk23Qh1QxXwgCzrNF9gTH4ZudPMEn2UtlQJmKqQYDI=;
 b=kzZVnW0swrBX8xCNFwUGSKhP1HiefH2s/FTiC6WVOEfrzqTiE/bRpCTk9aqcZ0TJY8EKux6xLYLxVMUNCSMhegAE7rj5g8oyk5ckq7V+dVI1SYFn8z32ukNHqMH6c+I0c9hl2elRaJiwNbV2TdwCoAY2ntr0hH98qyD84ONv1TM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6487.namprd10.prod.outlook.com (2603:10b6:303:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:58:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 18:58:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Chuck Lever <cel@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/5] Possible changes to nfs-utils junction support
Thread-Topic: [PATCH RFC 0/5] Possible changes to nfs-utils junction support
Thread-Index: AQHaG+Lh5GJB3YfmqU+85mdG033FiLCDjyQA
Date:   Mon, 20 Nov 2023 18:58:01 +0000
Message-ID: <BC1CE17F-3A09-49F8-81F1-C6D5730F2A20@oracle.com>
References: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
In-Reply-To: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6487:EE_
x-ms-office365-filtering-correlation-id: 14ccf39d-422d-4844-6295-08dbe9fa9e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbOZ3z+ILBTvpQkWFpw4q+C4j3Y0ZztPAiEDxvlGbyxSTOjhBnun56HMqQrz/5eCTEJX+6kmcZWZuEPQobne7O4eGc8zXoRMcxrZiO4QFmPZk/T+R6HhENwpYtDxuOK0BmDXViA5uggb8I7n3sVPiWIXBRuLlvXhqwi2mUfsmY86HU2bU8ThM0bi8J4bSN8Cl7xsxUKwLpit68mA8eFLa+tuQ4Ti/XDGJUXO7PkQDzJf424h0Pjk85ldRvhOhO3bPRJl3tgMatG3fA0MI+QaA7sD7KjOMSTCE3RAbf1yxEOp3Fv2LKS2A7OVlLgmcMbd3zvu83LESo06ofB8V+cK4VywZcpSjfjPl9t+MN3JvbZuxQrwKSgFuede+PEeqXrE3kVsopzOCcBOgmNnw1IjxKUo5mf81Rza1pMQbU2FPmTJfqwnbEjqri1AhyMWE+8NuVo0YXqQnwI2NkK2TohVShDeR1l1scyt7rzr7tw6npNscfzMlSoOQojCR3HeveKIyfVH0UafJnTLZel8WBVWbB/MSIWag8hQTezHKaTjc7C8TqGvjz0OR8ELMUHkdEx4F/SsNeG0okppM2x/xKW3J/gbQ4JFXa4Lh0qQVNKl7+5WLJjYgyV0UEQSrX+NCplb77chyC8SpKc4Z4EPfOfUxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(91956017)(76116006)(66556008)(66946007)(316002)(6916009)(64756008)(66446008)(66476007)(26005)(36756003)(8936002)(4326008)(8676002)(38070700009)(38100700002)(41300700001)(122000001)(33656002)(86362001)(2906002)(5660300002)(53546011)(83380400001)(6506007)(6486002)(6512007)(478600001)(2616005)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUVMSXVJUlBwcENQam5YT3N2d3FNYmFQdnZveHpvVWpJNFlLRUhNSUdSZWJX?=
 =?utf-8?B?VFh2U0x1Z3Vla0srR2ZpYVcwa0ZadXpSbzdlYU44SGtROHdOVTdPaTdKdzhw?=
 =?utf-8?B?RzE4WTlmMkk2ek55NlBzMzJxaUNYWTVtVmtnOXgyM2xmOFNDa2tLTllKb0FO?=
 =?utf-8?B?dkxRbG1IWkE4bmdCNFd6S3hDVUhFR0NRWkJCbG5YYzdSbTlCUllFd3NYVE1G?=
 =?utf-8?B?OUU0SGk0TmdmWFBIejJHQ0dtYnlKVXU1aGR0MnhsaVR2M3FoTGpXWmhtazBj?=
 =?utf-8?B?cGpIL0NIb2dMZFNFVnRqRmsrNkIwbFpnUmtUeUF5czVXTVVBalltS0w4aUJy?=
 =?utf-8?B?M2EyZEhHa3lMYmJGRTZ6bEpBSVE5ZU9ZRDJtZFhMc2dkRnB0V0pTWGdOMHlE?=
 =?utf-8?B?YmIvVThORDRFZHR5YkhrcG1RMzVaenFoNU5vL0tRSm5PdWFMbkpJNkVCL21n?=
 =?utf-8?B?YjJ0NnZWRXozaUwzUHh2Q3g2S2dqOVNuanpBQmpoSTc3Yk4vMlp5d21oNDEw?=
 =?utf-8?B?eHpJN25tSEtlMk9aYXZVd09RQVBzVFppcEYwRDgvWTU1clpxcDdGVThQWG0x?=
 =?utf-8?B?eVRLZkdIKzN0Nzk5SkE2QW1Pb1F1M1FEczZ3Sy85bHJ3dDJzbEp6ZXlkNWZH?=
 =?utf-8?B?Nmp6M2ViRHptMGdwT1V5V3h1WEE5dTM3VTlLZ2x5QUZ3aStMVTZZbnNsTTg5?=
 =?utf-8?B?ME5aaE9rTlVLTG52b3BLeUIxbThTOXlUa3JnOTNLUjdnWExIbjA1SEFjV2tp?=
 =?utf-8?B?VGh0eXZ0dFo0bnVvQTZhd2RpQzdDbDQ3Y2VyWGIvb2M1Sjg0ekx4dHA4VDlE?=
 =?utf-8?B?bklFQ2UvRE9JcGlwTDdZVzNMSFQxNnVrSEZYV1FNaThzTGJKaFpzd1pLREE1?=
 =?utf-8?B?a21pUUpYbnczWmI0amFvNEJ0OVVMQzFOOWdYcVlESVdKK1BZcEdBZCtPUFZI?=
 =?utf-8?B?VU9ieVI4elpXYU1Va1BaMndwTE1FY0QxVlNDQ1FnaUlDQUdTd2NXOG5uZExO?=
 =?utf-8?B?YjdVaG8zcVo0OUh1cCtVSXR3cjM3VklEZDdNNTNVbmlRNDZtZzFUZG51UXNO?=
 =?utf-8?B?UWJiK2liblJGeVZHM2lCdmhwS3UyZFZCM3I4Ny82Y2xBR1JsZ0dIYjlpYmVq?=
 =?utf-8?B?d0JIV080UlhTbGNERjl3Ti9KZDNYZnRVUWFRM3FwaWlCd3FwRUJaNW9oMmxj?=
 =?utf-8?B?YnJkTDR5NDk5NnVqKzVIc1lSSmVWNEp6Nk1ZQmtxa0NORE9KNU9TMS9UenNj?=
 =?utf-8?B?M3ZEa0hyN1oyWWVJOVNzSUtmbkFSbGxyNTJEdklIR1ltV0RxZHkrK09hN1lB?=
 =?utf-8?B?cXgzeE1RVDhrdzNQdVh4blZQdEJ6QTB5aThsbUx0bHA4QnltWkNhc3oybkJ4?=
 =?utf-8?B?cjdBUmlEQy9FWUwvaUNTWWJ3SGQxQW5IbDRaZjZZbVVKNlZac2dvMDVpMVhw?=
 =?utf-8?B?TXd0QzVDS2EyaWJvb2tLOU1sMnFmVE5nN0ZOSXY4ZjhSK1B1cDFHdjZ3MXkz?=
 =?utf-8?B?eFdvUUJWNmtBSldUNEFESDVGVnNWVVRiQzZ5TWxYaUpOcVh6dGE4RVowMXhr?=
 =?utf-8?B?aG1IWkNobWdDUFpWZVpuc3h6dFpEdFpOcjJaSnJGcyt2cjNTaG5Fd3ZrVjJx?=
 =?utf-8?B?RVdEREIvSXRaN2pqZkVFVEY1L0VCS0tRUU8xUWdTUzZneEVLRS9xZWZwQzdm?=
 =?utf-8?B?R01EbUN3V0JsTmExeDQzYyswYnlYR1hLUzFCRUZ5SkdJaW0xSDd2b0hsNHdo?=
 =?utf-8?B?MUQ1bXFVYVNQQU5CRHNIQWs0azdXbnc5UE4wbFh1bENLQkptRXBxSDNvUjJG?=
 =?utf-8?B?UTJIbG9ITFBVMWMvSlQzcUJhZkZXWm5qdEJrU2pyN2M0OWlnL3RVZzBTaTlw?=
 =?utf-8?B?M3F2Z0krazVKRmtxRUpFK2RoRWpuUzR3UE1wOFVRcGl6SzFSWmxLaTNqNlZB?=
 =?utf-8?B?ZnV1UG9wS2YwK2ZnMzRMSlJhRkFnOXRlMHRPZkdpa2U1Qnk4ZFZEUGRmOG5R?=
 =?utf-8?B?cStlV3JSOEhTR01tdFBwUVFIS2JTb0Y2cjZPTGRaWG1nWUpiUFRLMGpJYzB3?=
 =?utf-8?B?dEtDeXNrVndjMVpSc25xSFpVMS95WU1lTkl0eGx6RkdFeVk1cXlmZGRrdVBh?=
 =?utf-8?B?RUVmOVE1S3ExcVU1cjQzN2FSeThLOFpFeGhMWS9zSUpiYUJJZlIvQjdiVzZM?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54DE114EDD98BC4D8227E62EB6B2EA18@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ltS4W6W4/gsqvTVBCcuFlr8TnbBMD5n6GyKg7B1tysmn984Y83we61M4D6jlUuDkiDidlr3xdy6TrP6JcbsoNA54vpoOCoohtn1a9F5HXsuyGDYrf2lNQqSd/zY/RV3Aw0+ol2EWbuCUIzUuK7I2qjhTwwcKQEafHbvvL6EIZ0uBOLrG41sYUDS1qc6Wgl7KKmfGkmoQ+1ZPJC2vFcxZ6+xei/989WmNYraJbrAlfop3JNq4q5+BrdcuodyBSCq0ktA28ncJJzaz8+mjuCWW4rQAAZwfQ2K5fSXw2urLS+EBkY4+GEf7yb3Jvvy1G8OZ67OpGMKRr7Py+843ZNzOUkmbK1aG6X0eQ8z8JpsC+/tqK7vbJ1g17jHLu5+zgZtT5k33eRK+lCkYXJ/L9B1p55Am79PVNIpy0unfr25bovdATOsTB2RP2IVVv++Wcc1e9/VOwgHRLPBqp4jcRkhs55tb8DhIbKoS+Ua+shEAiDL0U3dE0x3d4RbgKV/GFHqiSBQ1Vu/c2vNytJDiDFkohbQj78LtJmVCe13iPB3Mx+0jnslO/qurydXnvLlim2/DLbogn6AZgw2TyT4uCoW3CVZZJ9Kc0Oq1QEazpIVYLdStr0ylT8owIbAnoBR4y6Kog7YMf+0uoWcnDmrd4TkTXiRROTBOUgAsabaB0f817N/3UotYRi9OSsJ3/0ycFaGbIk7N7MjetXMySvk/i/IhZiJeoINtmYCxqAdeUYAF07PAHtqCRLG4pHfHMNz+g8zZZQganiid7uxZ1rfIlJPGbNQ4+NMqTqgVN7fj+YSGWJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ccf39d-422d-4844-6295-08dbe9fa9e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 18:58:01.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jitzmMNEhRe5e/GUVo/Y8UaLWn73esKyKyjRSzvBSiSoe60Ao9jXs/9+TIra07fyxjBTStrb1aI3qdSxGPC6bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200137
X-Proofpoint-ORIG-GUID: ulU3Z7DjzKNylnPz6hlXwpyhuDm3ENYG
X-Proofpoint-GUID: ulU3Z7DjzKNylnPz6hlXwpyhuDm3ENYG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTm92IDIwLCAyMDIzLCBhdCAxOjUz4oCvUE0sIENodWNrIExldmVyIDxjZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBCcnVjZSBzdWdnZXN0ZWQsIHllYXJzIGFnbywgdGhhdCB0
aGUgbmZzcmVmIGNvbW1hbmQgc2hvdWxkIGJlY29tZQ0KPiB0aGUgcHJlbWllciBhZG1pbmlzdHJh
dGl2ZSBpbnRlcmZhY2UgZm9yIG1hbmFnaW5nIE5GU0QncyByZWZlcnJhbA0KPiBiZWhhdmlvci4N
Cj4gDQo+IFRvd2FyZHMgdGhhdCBlbmQsIHNvbWUgY2xlYW4tdXAgaXMgbmVlZGVkIGZvciB0aGUg
bmZzcmVmIGNvbW1hbmQgaW4NCj4gbmZzLXV0aWxzLCB3aGljaCBpcyBwcmVzZW50ZWQgZm9yIHJl
dmlldyBoZXJlLg0KDQpJIGZvcmdvdCB0byBtZW50aW9uOiB0aGUgc2VyaWVzIGlzIG1hcmtlZCBS
RkMgYmVjYXVzZSB0aGV5IGFyZQ0KY29tcGlsZS10ZXN0ZWQgb25seS4NCg0KDQo+IEknbSBoZXNp
dGFudCB0byBpbnRyb2R1Y2UgbW9yZSBkb2N1bWVudGF0aW9uIGF0IHRoaXMgdGltZSBmb3IgdGhl
DQo+IHJlZmVyPSBhbmQgcmVwbGljYT0gZXhwb3J0IG9wdGlvbnMgaWYgd2UgcGxhbiB0byByZW1v
dmUgdGhlbSBpbiB0aGUNCj4gbWVkaXVtIHRlcm0uDQo+IA0KPiAtLS0NCj4gDQo+IENodWNrIExl
dmVyICg1KToNCj4gICAgICBqdW5jdGlvbjogUmVwbGFjZSB4bWxQYXJzZU1lbW9yeQ0KPiAgICAg
IGp1bmN0aW9uOiBSZW1vdmUgeG1sSW5kZW50VHJlZU91dHB1dA0KPiAgICAgIG5mc3JlZjogUmVt
b3ZlIHVubmVlZGVkICNpbmNsdWRlIGluIHV0aWxzL25mc3JlZi9uZnNyZWYuYw0KPiAgICAgIG5m
c3JlZjogSW1wcm92ZSBuZnNyZWYoNSkNCj4gICAgICBjb25maWd1cmU6IE1ha2UgLS1lbmFibGUt
anVuY3Rpb249eWVzIHRoZSBkZWZhdWx0DQo+IA0KPiANCj4gY29uZmlndXJlLmFjICAgICAgICAg
ICAgfCAgNiArKy0tLQ0KPiBzdXBwb3J0L2p1bmN0aW9uL3htbC5jICB8ICAzICstLQ0KPiB1dGls
cy9uZnNyZWYvbmZzcmVmLmMgICB8ICAyIC0tDQo+IHV0aWxzL25mc3JlZi9uZnNyZWYubWFuIHwg
NjAgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gNCBmaWxlcyBj
aGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IENo
dWNrIExldmVyDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
