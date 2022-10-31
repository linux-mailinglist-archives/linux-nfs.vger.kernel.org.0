Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF36137C3
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 14:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJaNV7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJaNV6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 09:21:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835865BF
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 06:21:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VCaJJL023037;
        Mon, 31 Oct 2022 13:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ogXd8vzyY7wZ9xK3Vle9xDYpx5WNadbRVcT7NHz28T4=;
 b=lSQm+uqfapDyyWzkyQynygOdWIiYTh5rX4VDhOJG3ao2+SKO6iV/1GFwYK1Pu/e7wCeZ
 G2CX54OLYfOIsVjBhYAj8Y0V7CK8Ehfiye7QEx2GeKj/DS/W7/M57eo9qhVSFQz214Qj
 C5EAUglfSCB3s0XDiRw7FtwUYssn00JUYHTrfSkPiGtHQP1msJjhlxNfRGbLs2wm2m8G
 vCmphOAXSJGIzA54nho6Gw7DLuXMRCRt24tSeWga9vwfd83sUYus6zRLeLVDXpP4iXx6
 QeZ3bWUKgUbcXQ93ADub+kGOEnpFkcnDtWPkMzbvMxDGwlrtj5hv4+OyHguuF0r6O8H0 VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts13k2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 13:21:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VDBRQi008011;
        Mon, 31 Oct 2022 13:21:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm39d37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 13:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVGTKKxysQL0lXUi7TCASguCQrGixBjgfjvQhDeoQBEpwe5yeQ6vwuVIcw0P+Ji2h5eJEWwZ1zpYvtMUaaXPCsj4vUgyUQ1WoUzadR/6n+vy4dBqpMVgm/lOd9QShZy4nEZP7Sw2XekQy9pxAR9SB9vdyYWsjIeAEzsL3UwoZXL8souSwUv8ku8Sv8++7dIrpTVdLDYADHdqgN5nnM3YQxPNGX+HfYs+JtXKht+IVRAWo380ZCzxQReCFiAlFPRWO3bqYgTL63BZSPeIyIgB5rv2OZ7E5Hz+U5EeDLrV5EkSOIGZK+g3hsTDy52nGVjGim3kNpZMg6KjrbI22e6v4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogXd8vzyY7wZ9xK3Vle9xDYpx5WNadbRVcT7NHz28T4=;
 b=mz1d3WcSex2j5Mo9oqoXz4N1oKIOZr+luj4YEH5N6RZE10u/O+VX1CMdH9T8NISbIx4fRmFXfAEv1xsQa2YeZqzyhmaW6P//uPCmD+DkzK4zLyuzNA6QPegfykRXC4rx1D7ExRW3LWcKYVJ9UIzKHswcuWgOqToDaSqSTp2TSeUuApATmOGOCwKagR5/1v7L6Wdzhn//WKDOX4d4ToyFYSuShIPCdOyfRf6wngDEOdISU5WDWPtLBGgCJWSBkqnz0E7zk5bpDZ2ZZnqKmho/9gdr/3u/f5tqYe0hTKFBXfrLD4ospCq6rh0hzytPtf/cA6qpYcdQ+xuPYBsMRMBTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogXd8vzyY7wZ9xK3Vle9xDYpx5WNadbRVcT7NHz28T4=;
 b=tQpWXKyc8+m3FLUtEpmLo3DHEJQ065sE+AaxbHtOXIouhvM+6x1/WwYxWkuPEgN+VO4vjfy9LBWeoCy44EamLVPMJcyMdr5X7nG8iwGy8fB1dN1RnDoDNEKxYYich+kbxtcnogTZvtgqGSNhWL859kwuM+IxNrzaiEY9RbFmFto=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 13:21:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 13:21:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix licensing header in filecache.c
Thread-Topic: [PATCH] nfsd: fix licensing header in filecache.c
Thread-Index: AQHY6UgyJjhEsyzLKU6cRbJ9KOmgVK4oK36AgABZYgA=
Date:   Mon, 31 Oct 2022 13:21:45 +0000
Message-ID: <3C6909FD-6079-48AC-93E2-BD7937E31F86@oracle.com>
References: <20221026143518.250122-1-jlayton@kernel.org>
 <Y1+A7XzxKbRCCH4z@infradead.org>
In-Reply-To: <Y1+A7XzxKbRCCH4z@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
x-ms-office365-filtering-correlation-id: 4d464b32-5b52-4d3a-075d-08dabb42dbb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UhN2Tj67Y7fAxy1kBmKpJeSKwR/GB9NmFl+W96GHzZZU5RIUOgzZSbfJGGr5Qlr2/jTSJ4luy4XGHoH+2WhJD1/nXVnMNB3wvtK7jWMdYaPReUBZTTAfRPXW4gibIXiVKEDLf3Fxuulsiu3i8kbDJ16I/gp/Fh85B8H6O7mzSCimr+d0bbC1GJP8f2hdkH9DBVFhYCd7YcQ2zcgz2091oDcfqA6cY4QX1gEWgIMOF4IRhMrC30E5jgFbaTpIhTrOyMJWSadpccjnLMiSW4TLiHZkJvl5coDy3Iv3W9wXWcpWetrAK0aUk9LexnR8kYDFHou5jVO/D1+VY5aaalSNmd/Df3OoxPKIuaGeYY5HH5BbmhciZOOG252lRv7AIYMFefGBS9lN3cHkNz2u9Muyd6R3FK3R04Z+/JoVrzBohU7N2PoCnktp1VkgKPdbEayBg3enzE3dS4n8bnlPpP/at7TJhzlNH8rm792j9OCSRv3SbolsgtdUDcY8rtHQHxMnh03xNKIYHHKn03pvVt1QjNE8Z8BO6/OOkHbGosyE2OdG3Vp7bbrgXAahEQTQsLDvyheDbVf7uA8+DUpCP562hxXkq/5O/16+piZYItZAZmm7SCAY4vG/NTqvMAxWNWgYlzu7VJP6C/7vGQIHo5xUwI+B2OcomMWKiwCLJJuEP3DG1emnYwwpQgJE8hiJJw7liBzr5lzGkaS5IdUvLEZOhjTCBLSH3JrHavEiT5wSxrevEJB2MA+p0J9nwnS2jOznWtFv0+nZS8gbohVk/gMtUdayV7aDl4xDzJdjgU34BWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(8936002)(478600001)(33656002)(86362001)(316002)(36756003)(38100700002)(91956017)(38070700005)(4326008)(53546011)(6506007)(8676002)(66446008)(66556008)(66946007)(66476007)(76116006)(64756008)(26005)(6512007)(71200400001)(122000001)(41300700001)(186003)(5660300002)(2616005)(4744005)(6486002)(54906003)(83380400001)(2906002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THdKd1piVDNtampJZm5QdStPTFRlUkJ3Z2tnWCtPTnA4aWZrWUNCYSt2dCt1?=
 =?utf-8?B?UlBDZmc5YjVPVEFteGJOSG9VSHZkOEZmNDg2OWN1NTJpZ2dRZWc3TWhUNkNv?=
 =?utf-8?B?emhDSlNrSlJ5eE8yT1FsOU53UVBmK1owRDFxVmg5emNBempLOXZRZjMzZHA5?=
 =?utf-8?B?ZVZyKy9GL3NkSWlCdDl1R3Bzb2xjVXRIbm52S0tmMmhES1FsRC9EUkJ2Q3o1?=
 =?utf-8?B?U0UzTHZjTnk1UmdoOVNnbG8xZzFrN3VJdG43bzA4VENhbDJQbUROMkx1cEpD?=
 =?utf-8?B?OWNjellvVXZHMkdlU1pYaFlMcEttdHlhKzlRNUVVaFZ2L2FuL0RDRDVRZkVH?=
 =?utf-8?B?STZvV1BWSW12OU9GSXQybkpJQkRvTThMOFIxVmcxRUxGSXZoUnk5UE12N3N6?=
 =?utf-8?B?NXh4bmtOeCt6ZGhwa29aaWNlWE45R3VORUh2aTZsT0l4SnN6QVpuQkhkV3lq?=
 =?utf-8?B?cFNUTHBab3MyN0p6ZDJzeDhMdklsazkxSFlrSjEyU2xnSHZtNnpuZEt4N01H?=
 =?utf-8?B?SEhScmFSa1Qxd2tQVXVxK0RjNDgvYVlSbGsxOUZGZFM1K09paDVZVGxFNkFq?=
 =?utf-8?B?U2EwT2lGcDE4RXRBcjRxRjBKRVIrMjIyUHI2cXExdHpRRVBCcXlBcFdLZUtx?=
 =?utf-8?B?eEJRdWhzRWJGeDJlOGRKMWozaU1uZDEwMVFpZjlYaDVSTjZwRVdqMUtPR3pw?=
 =?utf-8?B?Q2gyR05zcTBjZVpoLzZUeGFIbVprWmtiZSs1MDg1dmtwT2Mva04wai9WbS9t?=
 =?utf-8?B?UVVha0hXZXBySUZyYzV2OFpVS3pGWG0wQk1mc3VjUVd5aXBtOHBnVnZjZjR4?=
 =?utf-8?B?aWY3clNPZTZMRjJRQS9GTmdSZzhxalIrdFRtUGhMMXJIR0ljdGt1Z1ZrU0ZX?=
 =?utf-8?B?Zk9oRFdsdUJUM3VGTjJYNk93VmJyUmEzWG0vNHJYZDhuK012eVliUkpxbGVO?=
 =?utf-8?B?dzlVZXZzZEtscVhKMzlqUUF0Qit1Y3RzRzIwZ21zZG9Fc0o5R2NJV0Q4cW00?=
 =?utf-8?B?MGViZDZ1QW93ZFBVSDRkQWJzSUtGMjdjbC84NndBbWRZVFN1YWlyWVZWUjhw?=
 =?utf-8?B?eW5zTzBiUFdkbnh1em02RjRGMzhJaFJhZExrVnljNFlxR1dUdXdzY3dGWkJE?=
 =?utf-8?B?SHJjMUQvczV5cVRPVjAyMStSZVJ0N3VaSjQ4NVNHdDJVbEZ3L0xBNFlsQ2Rw?=
 =?utf-8?B?OUphRXFCOGsrTHhSN1hHSC9GVExUWXRIMWROUUwvaU1RY2l5REVMTTlMR2lt?=
 =?utf-8?B?UTdvYk90NDUyblhJVjNpb0pjYmhzQVltTU9JRHc4czhFa2s0UXZpWnh5ZGhW?=
 =?utf-8?B?TE1SaHErdHNKOWhJZ3pjbkw4dkV3OHNVd0JHcW9ybXE5bjd2RWdPV1RsOERP?=
 =?utf-8?B?OEFRMi82VWM0L015RURMbmtrM05ja29meXdyZXNEMk1wRHJ6SWdKZWI4TzA0?=
 =?utf-8?B?aWViMXZVeGxUeFdKM0kvL0xYbmNYb0hkV2xRT2Y1K0hIZUF0Q1RqN0FHSzBj?=
 =?utf-8?B?ZDZvRktrZVlMdEtjZUJJa093a2l0YlRRSXdybmc2K0NuVnB2YzVueWNYVzNS?=
 =?utf-8?B?U3FIWi9PdU9BWHNHdUZBS1FRYXF6eWNia1JHVm5DbHNiU3BNempqdHJtRXVq?=
 =?utf-8?B?Mi9CR1ZDdXJVR1pqbU5OSzNUTHJtcG5xblhvM0NxWk14ZFZzeFZVRy9hcVkr?=
 =?utf-8?B?TUUyZzRmR281T08yTENXSTJsMlBKVkY0aEtVcFJrZGRURmovUThiM1V3aWxL?=
 =?utf-8?B?UVNrMWx6VlVSOXhPV0FVTFlYMDNDRkNhZWpQYm1RejNLR0IrV0t4V05OS3Rr?=
 =?utf-8?B?RnNpT2UvWXJYN0hCMXp2ZS9wLzgxdUluVVQ4bnFpVjlzNkZ0c3VnWHpJUC9F?=
 =?utf-8?B?S3hYazlPMzlweEJqQnZOeTVqVjd4b1pmSjBNbDZ0T3psT1ZwVVBnenUzeXRw?=
 =?utf-8?B?akpRVXdXcGtSL0ZidmloR29KYm9vaGx4TGc2WUtzaUtVVXVEUnloV0hWRTFu?=
 =?utf-8?B?aWdqcWE3TGt4dUl1MU5nNElJRWNpZG8yQmRnRVlDY1Q4VHAraTMxTDNIYm1h?=
 =?utf-8?B?MDB5L2RVWUxkT3N6MXFxK2ZNNm14NFV0Y3pISnRQTXBMN3M5eVUydWw0ZUVO?=
 =?utf-8?B?bk5XaU5EMzVFYi81UkhhY1lOV21ncnhrM2krWUR5Y2dHTXlwK1IzSDVIdVE5?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3185240ECE4DE746927B0EB1077B2010@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d464b32-5b52-4d3a-075d-08dabb42dbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 13:21:45.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCGWAvjJXmxBFsum+1AtUeYMKHkiBby6b9L0q+VJsWD1Xtw2lRDSN4+BZmEaFE9ZwGZX60CCWQv9+1/AEo4uww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_15,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310084
X-Proofpoint-GUID: z6D2tF0oN5xhrXkzk3mr9JMONN8qd1bz
X-Proofpoint-ORIG-GUID: z6D2tF0oN5xhrXkzk3mr9JMONN8qd1bz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gT2N0IDMxLCAyMDIyLCBhdCA0OjAxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBPY3QgMjYsIDIwMjIgYXQgMTA6
MzU6MThBTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+PiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4+IC8qDQo+PiAtICogT3BlbiBmaWxlIGNhY2hlLg0KPj4gLSAq
DQo+PiAtICogKGMpIDIwMTUgLSBKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRhdGEu
Y29tPg0KPj4gKyAqIFRoZSBORlNEIG9wZW4gZmlsZSBjYWNoZS4NCj4gDQo+INCFUERYIGlkZW50
aWZpZXJzIGRvIG5vdCByZXBsYWNlIGNvcHlyaWdodCBzdGF0ZW1lbnRzLiAgU28gd2hpbGUgYWRk
aW5nDQo+IG9uZSBpcyBhZ29vZCBpZGVhLCBkcm9wcGluZyB0aGUgY29weXJpZ2h0IG5vdGljZSAo
aWYgdGhhdCBjb3VudHMgYXMgb25lKQ0KPiBpcyBub3QuDQoNCkkga25vdyB5b3UgYXJlIE5vdCBB
IExhd3llciAodG0pLCBidXQ6DQoNClRoZSBlLW1haWwgYWRkcmVzcyBpbiB0aGUgY29weXJpZ2h0
IG5vdGljZSBpcyBzdGFsZS4gSXMgdGhlIGNvbnZlbnRpb24NCnRvIGxlYXZlIHN0YWxlIGUtbWFp
bCBhZGRyZXNzZXMgaW4gcGxhY2U/DQoNClNvIEkgd291bGQgZXhwZWN0IGNvcHlyaWdodCBvd25l
cnNoaXAgb2YgdGhpcyBjb2RlIHRvIGdvIHRvIFByaW1hcnkgRGF0YSwNCkplZmYncyBlbXBsb3ll
ciBhdCB0aGUgdGltZS4gQnV0IHRoZXkgZG9uJ3QgZXhpc3Qgbm93IGVpdGhlcjsgaXQgbWlnaHQN
CmJlIGRpZmZpY3VsdCB0byBnZXQgcGVybWlzc2lvbiBmcm9tIHRoZW0gdG8gYWx0ZXIgdGhpcyBu
b3RpY2UuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0KDQo=
