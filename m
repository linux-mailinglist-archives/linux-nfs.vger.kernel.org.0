Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A030770CBD7
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjEVVAa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjEVVAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 17:00:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766F10C6
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 13:59:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNu6m019632;
        Mon, 22 May 2023 20:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=acFhjFPQ8TIEEKJlTujcuSjBJnwIxUo5GylasrcZUL0=;
 b=dPplRODbrHGyCi19Z+u+W+bI750N6VmAf/KBm8VRWCEcELXZMZgNLDTQRGqq2MPDdBvv
 mX+GuJFcQOyda+0dNuPaP6ezJJxMLQikkiyBUo9uXQ+OgSsYN8c2APJxc4Hp1WY/iCm6
 0nlCFw/VqeHMaCyv221M96h/gT3QJRBjvD+lYvok1Khytgd5pEmzcfPGA8Wbt86escJp
 jtJjhxSeKRJpNW1HbV9odnz+yMVrYcegY+1JKmr17urTww34cdzesDEBPROG1UogQy1y
 /wu93u//k/K632O5GXYWronFT25uJNWKjUNZX6a2jGuARz6cspo5qKFQlLIC+zjMiPej Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cbrap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 20:59:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MJlDbr023544;
        Mon, 22 May 2023 20:59:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8tfp2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 20:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA5WmVplMd7JptRlnChIC0GsFA37ivrttT9O6C5qho4HvG7sbTG00pBYj+AGt6f128A48ANK/AenSbAjbjpNPpXNTcBMUtw6BNtoprH9PDNkpyPBuVAIU4b+bsC2qNlqhRFf00AhmnCeSfr9e5/qS1U6BdvCVvkoBCksBUssox9xr8FS4AIKKUWgH+pF4cV+avfzZUQlVhdycyBD/IFJ0YUjr08Tq0Q0pZeBZqc0zjgzFsCRlW0JbrQkoL/Pa1tjvOm/TuZINUlltLNvnFYt74TpwqmndZc5c9bL8S2D0Kc3kbJeowl3ql+OhKKAWx20+324pdVo9Vcy+SGlmMxhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acFhjFPQ8TIEEKJlTujcuSjBJnwIxUo5GylasrcZUL0=;
 b=nHMDTy6vdyI8vZD+4wj3ss047IQ7k5qh6imTmoOAK8B5cOBNjPLB3fMeUZ4Lp6iIgLkJPbSNV59BkHUWo15qOi1fO4GpoBQKIhDdv6k8rlvA7XwzdhvKv4lyezO5+aNfMpk3OxLnDzq1UI8bWiYJIKnLc7gbJw5nD9klmzOlftQQy8fWstQNaEiUhUh1P1k3FIR8K8MRLQC4gEy2490vOR/N9h1tdvLzg72xbYvNwSwm3gSbC16m0ibkgB3GiU0WMs+KGx7mLVGT5/C9p/+njh8Mfv7jH7hx4EQsLUhsIn2eoBsgBWemWtPy+ngHBuljwfsyUEao9+jxslTNZ1S2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acFhjFPQ8TIEEKJlTujcuSjBJnwIxUo5GylasrcZUL0=;
 b=X+UDDcQGiwCe90GgpevFCkUsFN+KwJdI9B1wy1dHysRDHR6yQqW6DwuVp+YOLxFJECN/+fTDkZQ/0MY1MU3HDvtbiH1T/zjl5XXT4zjWgOcH8/oOwYxwi91C5XVqsUOc2T55Ye2s4MAGqageND9C+XLl5RFa8g/nDaQfTLC0QXs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 20:59:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 20:59:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
CC:     Chuck Lever <cel@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-tls-handshake@lists.linux.dev" 
        <kernel-tls-handshake@lists.linux.dev>
Subject: Re: [PATCH RFC 04/12] SUNRPC: Refactor rpc_call_null_helper()
Thread-Topic: [PATCH RFC 04/12] SUNRPC: Refactor rpc_call_null_helper()
Thread-Index: AQHZiC5Fgfcz49ahCE6kQ/t0trhIHa9myY4AgAAGkoA=
Date:   Mon, 22 May 2023 20:59:15 +0000
Message-ID: <C793D303-A2F3-460D-BB57-5BE0AD42E91A@oracle.com>
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
 <168426600329.74246.10545150506762914826.stgit@oracle-102.nfsv4bat.org>
 <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
In-Reply-To: <CAFX2Jfk9up-eyLhe7s65E6+vBTjXrATREFoYJVkCBLAT_56o2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYYPR10MB7628:EE_
x-ms-office365-filtering-correlation-id: ca1852fd-db47-4278-02ed-08db5b076753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWa6uuRn40oGcw6zb5qXXC9JPfQEmEpBIZyQGysG4+a2zffQmpNdbovkHCyc3B6dch73rGiZs+wTlWmcng7MdYRneBE51GkBiz5+IxF2p5r634OICSKP1QlCgOGrbL6ryre4ToEjMhtL99uO25qORKLhnFgEwGEpSx1H8mjfmuHaM8lb9980tGJ+qMLPVlM/8HfMzzpd2lNlTvSYM5WyYB/O5riIoEdy/KA2gbFT8gIijDJE7lluOKVVRYfrqDnd6r5MDCOyH6RMdQPNU3piKHqe4kM/nf1sULhHUvV3XxP99Ci2E9hgV8vVaPWOsY+YgvTsptEE874UQT5PHqE0W00SSyjd+9b5RrtdZPC9q/AqHfC9dO9aquqb0elHdb+mRoiryk4foj61exMLke8wl1xFprvTWK4wPASciKEwvftHkPVbbEg0fiNpGSr+895PiUMytl97PPxUEpf2hz24HV6JEEMHTRcrd+nrJ0lzgoyWu83Btp29QiMJg2SBUr7HdhAkR7dIb27A8wYmpvbSu3o0/yGPwnogMwNXsIDd6HAzD/qgFVy86e09f09bZ0c822TiL41b3S9pwVcXStM1QoBLW5YUsPhmhkARxNvyv7BWbdNo+Gj1GGSe/ghlGcTt3KbAgKcurqG7zKHn9zmVSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(2616005)(186003)(83380400001)(2906002)(53546011)(4326008)(6916009)(76116006)(91956017)(66476007)(66946007)(64756008)(66556008)(41300700001)(6486002)(66446008)(316002)(71200400001)(54906003)(478600001)(26005)(5660300002)(6512007)(6506007)(8676002)(8936002)(38070700005)(38100700002)(122000001)(33656002)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1JMcHBZU3gwYUZLV3ZmZXh1TlpvWEhUVGJGN3B3RUxKbHlvQVk2Z0JPa1Z3?=
 =?utf-8?B?d0NmN2JuYjJJeVNIWHlNUVNmblkzQkdnR3RJSVBQdVlSeUpsUVNSeTR1U2My?=
 =?utf-8?B?R2hHYnBkNjkya2lkekNXYyt0SVdwdE9BU00vdmlobTkzaEJFQTF3WUpwcklY?=
 =?utf-8?B?Tis5NUE3U1N5c0puSUNoelVsUUNucHpISXZ1SVFlTTk0bmN1QUh6ZlBrNzU1?=
 =?utf-8?B?UnZvUmJXZU9RdEVldEh4akJjZithZU8rMVlBZXJ1UWFNYWlTSmxVN3dTLzdP?=
 =?utf-8?B?SndoaFJkTVdPVWdtT09sNUJlUm1DbWJaVm5PanQrNVFPZ1JXOG81TndKUzRE?=
 =?utf-8?B?Vy9QdkFBSDhKNTNPWjh5T3RZZWtJTzUrMVhkWmF5K1h3R1IyS01LNTlLbHp1?=
 =?utf-8?B?cnlOdEVuUVRwTGJkQnJ6cHg3ZXpDR2NmSUl6QnNCcjFPZVB0NjBOY2dvRUNq?=
 =?utf-8?B?UUR3Z1kwQnUwT1FEQzFXbVNDUENWZlQvRW1ZVWUra21MOWQzVlQyaElZVW1U?=
 =?utf-8?B?Um1JOGNscWZ4T1I5VTFtOUwzSWJKUVloU21wcHlYbnlrOTdyWmdHY0xKWGNS?=
 =?utf-8?B?ZGwwVnNNalNhQmd2UEFTZmo0WUk0UGlqTTZtdzBpMU1qSXRQTk1OendtQXZE?=
 =?utf-8?B?S3BycnZHaktSUCtiNG5WbWpHNGdGSUNJZmM4b1V5UDI3K0hLUDFuUUtuVVFI?=
 =?utf-8?B?Z3dhOEk0UTNjOTd3N0pjY25Pano5VnBCSTI4ZGtOdWRselRTdmRScjVoeVJl?=
 =?utf-8?B?bnptQ01hNUFOSjRnbEtqQjZCMUZhcHFuNVROYmthdkdMT2pZTXpJWmhJT3BE?=
 =?utf-8?B?WjF4cEdUL1RrUlNiUGJuUG5WeEVFRlZUUlRwZXJMblFsRFF0dVhzcktsUUVH?=
 =?utf-8?B?M252M251VlMvbXZPWmsybndLYzduOHFDTE94QXpOcWRqK1BTMEZrZ0NBN2JW?=
 =?utf-8?B?MHlQS2J4UllMd1FDTUEramcyUHVuVzZPbmQwOExTeDlmNWloK0hBNm1Ka2c0?=
 =?utf-8?B?S2FyRksvMVZvcDRaOVZqM3FiM3I4T21SbHl4OGFsUmIyOUFEZGJralJ2MjBa?=
 =?utf-8?B?RklLVFczSlR3bXpmSHd2YnRxY05JYVRjRHdSL0xlelBrZjlhOC9RL1NnYld4?=
 =?utf-8?B?TjVpYnU5cUQrUXhzc2xYekdOY2prUmxYNkhXaTc5dlZOSjR2aTlYZCtHWmQr?=
 =?utf-8?B?M3Jtc1hGRVJXTitmSmcrUGRVelZHbU5QSGZsSnUxbm9Gb280WC9mdW1YMkh6?=
 =?utf-8?B?UnllVzY1dUU0ODMyT200STBQV2l4endGVnF2SENaRHhvWDAxa2tkUmNqTHp3?=
 =?utf-8?B?ZWZPbXBobkZTR2xydThCT3F6T1ZCRXlVOGNsQlBpdnRuazdDbytBSDYzajRE?=
 =?utf-8?B?WHJ6ZkxubVl6MlRQbGpUazdXZ2RUb0JOdHVpejBZUlJHSUJLK2lFT2tuMlJs?=
 =?utf-8?B?S0hnTEJ1SEZ4a1U1VmtEOHF5allQcHRhcTZwSEFHVi8xaEc1RWVaL01CY0h0?=
 =?utf-8?B?bWpFZ0tDUW9FZWNpYWgzVHRqM1hqSlZWSWx1YWtSbFgwMmU2K0JmR1dHRXB5?=
 =?utf-8?B?VHhEdVJUaFFKUENOWGNrZXpmN2NvM3VsT1hqRDk5NE1MdjhvYW1MM2F3OW12?=
 =?utf-8?B?d2pqczQrOTk5ZkhPMDUxdUI2QmUrcEhCclltSldIa3hMMHg4eDQvb1NVT2Nm?=
 =?utf-8?B?Rzg4NUVWUTVqUWtrRU11SUhCNW1mempRaSszRkFxLzFZK3kvelpxMGZTb0xF?=
 =?utf-8?B?dlRoZFRhZnExWHd2MVZ5M3huRWswbVpVMG9BMlhDUzlxVGdXMVR4dXhtWU1n?=
 =?utf-8?B?Z05yOWRhSU8vUlA3dlhZdWJiZjlMNW5jdjNILzNhekg5Zy9jT3JOL3Mzb0Vs?=
 =?utf-8?B?aWNlZHgvem0vOWJCMzJhckQvQmQ4WThHYjErZTJRbmhwZmpxTlBtdkttTEt3?=
 =?utf-8?B?dVV1cnhheUpUUzNzbUE3WGl4U1BaeWVrZG1TUlE5TEJodVcxVGNUSVc0bEdt?=
 =?utf-8?B?M1hZRkJidGJKaSs3SVFCNGdrTisvSDZVTE9zSnppNHVBd0tlTzdpQXYwOXhw?=
 =?utf-8?B?d1liT1BsWWtIODNhdXplcGFSdHRuYlh2QkJaZEhIM3VreTZWTkdlVDZOcVBt?=
 =?utf-8?B?UzFnMm5aSElJdnp0Zzc1VVd5RU9RTmYybHA0bGhBREN0OStHYTc2d3dyTGdS?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <985E551057F5BA4DB2A7A2C7BA522A3A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d1JkR2lKb3pZOHJXb1k5ZUxrcTVRLzlwTUx5WTlmUFNXMU94eUNhRXBGZlVy?=
 =?utf-8?B?VWpRckh5dlpYSDc2YmtnemdZaU55Mk9iekJPT2dFcnNKVytVTDc1R1JSbUVO?=
 =?utf-8?B?UThJWWhPRXhwUG9pMzlSdEM1bHlSZHpNbmthSlArRU10Smttd3RFbVNGV3FE?=
 =?utf-8?B?UnlETDFqRWtXT3JkZXY0QURlRW03QXZCTDF4RlFVOUhLdGdyVU9vbHM3L05k?=
 =?utf-8?B?TExiM0RJWWp3Ti9ValRDSWFLSUNmYTcyb0ZhdEI3NmpuWmIvZWFjaFo0MWZ1?=
 =?utf-8?B?MDREdFBVMVFWUHRxUGhBc0xOWkpRWW1Za2pzVWNLblYvUm5JRndST1Rja2tN?=
 =?utf-8?B?L254WHQyY0lUR0V1aVVOSGlYOEM4WWZCTzNZUjh3L1FYSUFsYVUrS1UxMnF3?=
 =?utf-8?B?NWFWR2g5YjR2dVdpY0hwVzRyL0dNd2VKd3lJeGNNYjJGVXpHaG1QdkxvaUdT?=
 =?utf-8?B?RC9zNzltS016WkxrVDJCZm9yWXBzNlJ4dWdzbFlDV0NFQmdpS2VEZXoxT0xZ?=
 =?utf-8?B?clNQa3BycTRWYmVVT3grRjJ2N1NEc242ZUloTnpRUUZvK0dBa1VPMTQ4dzVz?=
 =?utf-8?B?amNVOWpDRFhOcFF2dnp5MG5FNmQ0U3ZRSy9MdisxMUl6cnp2dTN6SkJJRys2?=
 =?utf-8?B?cmdmdUFpL053ckUydU9zV2JxVFdseEJIdHZwd2xGMEQyanA0dUt5VWZiUCt5?=
 =?utf-8?B?aUc2N0wyeEJUNkVFd091QzhER1ZhczlLSmo5RTJ2c25hSWtMZ1NKanVFbnBa?=
 =?utf-8?B?RlFIaUxVUzlSOWNOVVRaTE5FZkFUeDMzNEJmNTFjRWMvQldtYy9wZ0xWYTEy?=
 =?utf-8?B?VldpaDBwTk1aZjRaRHVsemlwN29OdnNMbXEyU0NIUlF6ME1pR2U4VzBacjF3?=
 =?utf-8?B?Z2hlNVhyMDJ5RzNvQ05BT01xUm4zUFdzR2ZIMUpxT3FvNXJrRklaR3RtU0VQ?=
 =?utf-8?B?MktkcldwYk9wNXRiK0dpU2NicEI0NjV0emkrTXRZODl2QTBvYVh6OUVFQ201?=
 =?utf-8?B?ejhxOFlkNmtkaHNVTzB3RGM5NkFkZmJ2MTNBYzUzblYrOGt5MFU5bmpDYzVa?=
 =?utf-8?B?Z3RjM2ZMZHpSV2JGU0pNdXE1UC9vU0ZhR21SU1JHbUJrSmZnQVp6ZnVQYkNj?=
 =?utf-8?B?VExTWktzRCtKaDZxcmlGZEYzYXBwTkVLeVZHeVlwdTFwVVVqTzBpSERlaUcx?=
 =?utf-8?B?Y0poRitxUGsyeEszUWtGbjVyeGQ1SHVNK0tlZVlFV3JrekpteU9La3phbFpr?=
 =?utf-8?Q?+77rFKLKTRTvBrX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1852fd-db47-4278-02ed-08db5b076753
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:59:15.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEIJehm6q7s+2uF2h4g0dAffOQGLv3VFpqEV1yd5dAsYRd2ITOg/9AyIXAixKYjdH3WMZKGaiti+8okMRuMe7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220178
X-Proofpoint-ORIG-GUID: -Xbl-NMcttuFIwubvp4QeKINsXXkvMz-
X-Proofpoint-GUID: -Xbl-NMcttuFIwubvp4QeKINsXXkvMz-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gTWF5IDIyLCAyMDIzLCBhdCA0OjM1IFBNLCBBbm5hIFNjaHVtYWtlciA8c2NodW1h
a2VyLmFubmFAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0KPiANCj4gT24gVHVl
LCBNYXkgMTYsIDIwMjMgYXQgMzo0MuKAr1BNIENodWNrIExldmVyIDxjZWxAa2VybmVsLm9yZz4g
d3JvdGU6DQo+PiANCj4+IEZyb206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29t
Pg0KPj4gDQo+PiBJJ20gYWJvdXQgdG8gYWRkIGEgdXNlIGNhc2UgdGhhdCBkb2VzIG5vdCB3YW50
IFJQQ19UQVNLX05VTExDUkVEUy4NCj4+IFJlZmFjdG9yIHJwY19jYWxsX251bGxfaGVscGVyKCkg
c28gdGhhdCBjYWxsZXJzIHByb3ZpZGUgTlVMTENSRURTDQo+PiB3aGVuIHRoZXkgbmVlZCBpdC4N
Cj4+IA0KPj4gUmV2aWV3ZWQtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+
IC0tLQ0KPj4gbmV0L3N1bnJwYy9jbG50LmMgfCAgIDE2ICsrKysrKysrKy0tLS0tLS0NCj4+IDEg
ZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9uZXQvc3VucnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+PiBpbmRl
eCA0Y2RiNTM5YjU4NTQuLjJkY2EwYWU0ODllYyAxMDA2NDQNCj4+IC0tLSBhL25ldC9zdW5ycGMv
Y2xudC5jDQo+PiArKysgYi9uZXQvc3VucnBjL2NsbnQuYw0KPj4gQEAgLTI4MTEsOCArMjgxMSw3
IEBAIHN0cnVjdCBycGNfdGFzayAqcnBjX2NhbGxfbnVsbF9oZWxwZXIoc3RydWN0IHJwY19jbG50
ICpjbG50LA0KPj4gICAgICAgICAgICAgICAgLnJwY19vcF9jcmVkID0gY3JlZCwNCj4+ICAgICAg
ICAgICAgICAgIC5jYWxsYmFja19vcHMgPSBvcHMgPzogJnJwY19udWxsX29wcywNCj4+ICAgICAg
ICAgICAgICAgIC5jYWxsYmFja19kYXRhID0gZGF0YSwNCj4+IC0gICAgICAgICAgICAgICAuZmxh
Z3MgPSBmbGFncyB8IFJQQ19UQVNLX1NPRlQgfCBSUENfVEFTS19TT0ZUQ09OTiB8DQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgUlBDX1RBU0tfTlVMTENSRURTLA0KPj4gKyAgICAgICAgICAg
ICAgIC5mbGFncyA9IGZsYWdzIHwgUlBDX1RBU0tfU09GVCB8IFJQQ19UQVNLX1NPRlRDT05OLA0K
Pj4gICAgICAgIH07DQo+PiANCj4+ICAgICAgICByZXR1cm4gcnBjX3J1bl90YXNrKCZ0YXNrX3Nl
dHVwX2RhdGEpOw0KPj4gQEAgLTI4MjAsNyArMjgxOSw4IEBAIHN0cnVjdCBycGNfdGFzayAqcnBj
X2NhbGxfbnVsbF9oZWxwZXIoc3RydWN0IHJwY19jbG50ICpjbG50LA0KPj4gDQo+PiBzdHJ1Y3Qg
cnBjX3Rhc2sgKnJwY19jYWxsX251bGwoc3RydWN0IHJwY19jbG50ICpjbG50LCBzdHJ1Y3QgcnBj
X2NyZWQgKmNyZWQsIGludCBmbGFncykNCj4+IHsNCj4+IC0gICAgICAgcmV0dXJuIHJwY19jYWxs
X251bGxfaGVscGVyKGNsbnQsIE5VTEwsIGNyZWQsIGZsYWdzLCBOVUxMLCBOVUxMKTsNCj4+ICsg
ICAgICAgcmV0dXJuIHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQsIE5VTEwsIGNyZWQsIGZsYWdz
IHwgUlBDX1RBU0tfTlVMTENSRURTLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTlVMTCwgTlVMTCk7DQo+PiB9DQo+PiBFWFBPUlRfU1lNQk9MX0dQTChycGNfY2FsbF9u
dWxsKTsNCj4gDQo+IEkgdGhpbmsgeW91IG1pc3NlZCB1cGRhdGluZyBycGNfcGluZygpIHJpZ2h0
IGJlbG93IHRoaXMgZnVuY3Rpb24NCg0KVGhhdCB3YXMgb24gcHVycG9zZSwgSUlSQy4gcnBjX3Bp
bmcoKSBpcyBzdXBwb3NlZCB0byBwaWNrIHVwIHRoZQ0KYXV0aGVudGljYXRpb24gZmxhdm9yIGZy
b20gdGhlIHJwY19jbG50LiBJbiB0aGUgY2FzZSBvZiBhIHBpbmcNCndpdGggVExTLCBpdCB3aWxs
IHVzZSBSUENfQVVUSF9UTFMuIEV2ZXJ5b25lIGVsc2Ugc2hvdWxkIGJlIHVzaW5nDQpOVUxMIGNy
ZWRzLg0KDQpXaGF0IGNyZWRlbnRpYWwgYXJlIHlvdSBzZWVpbmcgb24gdGhlIHdpcmUgZm9yIHRo
ZSBOVUxMIHJlcXVlc3Q/DQoNCg0KPiBhcyB3ZWxsLCBJJ20gdW5hYmxlIHRvIG1vdW50IHdpdGhv
dXQgdGhlIGZsYWcuIEFsdGhvdWdoIEkgZG8gd29uZGVyIGlmIGl0DQo+IHdvdWxkIGJlIGVhc2ll
ciB0byBzbGlnaHRseSByZW5hbWUgcnBjX2NhbGxfbnVsbF9oZWxwZXIoKSwgYW5kIHRoZW4NCj4g
Y3JlYXRlIGEgbmV3IHJwY19jYWxsX251bGxfaGVscGVyKCkgdGhhdCBhcHBlbmRzIHRoZQ0KPiBS
UENfVEFTS19OVUxMQ1JFRFMgZmxhZy4gVGhlbiB3ZSBkb24ndCBuZWVkIHRvIHRvdWNoIGN1cnJl
bnQgY2FsbGVycywNCj4gYW5kIHlvdXIgbmV3IHVzZSBjYXNlIGNvdWxkIGNhbGwgdGhlIHJlbmFt
ZWQgZnVuY3Rpb24uDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gQW5uYQ0KPiANCj4+IA0K
Pj4gQEAgLTI5MjAsMTIgKzI5MjAsMTMgQEAgaW50IHJwY19jbG50X3Rlc3RfYW5kX2FkZF94cHJ0
KHN0cnVjdCBycGNfY2xudCAqY2xudCwNCj4+ICAgICAgICAgICAgICAgIGdvdG8gc3VjY2VzczsN
Cj4+ICAgICAgICB9DQo+PiANCj4+IC0gICAgICAgdGFzayA9IHJwY19jYWxsX251bGxfaGVscGVy
KGNsbnQsIHhwcnQsIE5VTEwsIFJQQ19UQVNLX0FTWU5DLA0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgJnJwY19jYl9hZGRfeHBydF9jYWxsX29wcywgZGF0YSk7DQo+PiArICAgICAgIHRhc2sg
PSBycGNfY2FsbF9udWxsX2hlbHBlcihjbG50LCB4cHJ0LCBOVUxMLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUlBDX1RBU0tfQVNZTkMgfCBSUENfVEFTS19OVUxMQ1JF
RFMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcnBjX2NiX2FkZF94
cHJ0X2NhbGxfb3BzLCBkYXRhKTsNCj4+ICAgICAgICBpZiAoSVNfRVJSKHRhc2spKQ0KPj4gICAg
ICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIodGFzayk7DQo+PiAtDQo+PiAgICAgICAgZGF0YS0+
eHBzLT54cHNfbnVuaXF1ZV9kZXN0YWRkcl94cHJ0cysrOw0KPj4gKw0KPj4gICAgICAgIHJwY19w
dXRfdGFzayh0YXNrKTsNCj4+IHN1Y2Nlc3M6DQo+PiAgICAgICAgcmV0dXJuIDE7DQo+PiBAQCAt
Mjk0MCw3ICsyOTQxLDggQEAgc3RhdGljIGludCBycGNfY2xudF9hZGRfeHBydF9oZWxwZXIoc3Ry
dWN0IHJwY19jbG50ICpjbG50LA0KPj4gICAgICAgIGludCBzdGF0dXMgPSAtRUFERFJJTlVTRTsN
Cj4+IA0KPj4gICAgICAgIC8qIFRlc3QgdGhlIGNvbm5lY3Rpb24gKi8NCj4+IC0gICAgICAgdGFz
ayA9IHJwY19jYWxsX251bGxfaGVscGVyKGNsbnQsIHhwcnQsIE5VTEwsIDAsIE5VTEwsIE5VTEwp
Ow0KPj4gKyAgICAgICB0YXNrID0gcnBjX2NhbGxfbnVsbF9oZWxwZXIoY2xudCwgeHBydCwgTlVM
TCwgUlBDX1RBU0tfTlVMTENSRURTLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTlVMTCwgTlVMTCk7DQo+PiAgICAgICAgaWYgKElTX0VSUih0YXNrKSkNCj4+ICAgICAg
ICAgICAgICAgIHJldHVybiBQVFJfRVJSKHRhc2spOw0KPj4gDQo+PiANCj4+IA0KDQotLQ0KQ2h1
Y2sgTGV2ZXINCg0KDQo=
