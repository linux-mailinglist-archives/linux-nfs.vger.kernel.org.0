Return-Path: <linux-nfs+bounces-1011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E7829D25
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362C41C2197A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185204B5D2;
	Wed, 10 Jan 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eob69Q0U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vXRsq20V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBB4C3B8
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jan 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AF44j6023939;
	Wed, 10 Jan 2024 15:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+Vah6pweRH0OHLU+oIdqay7w525l6twRjCqehdMrNL8=;
 b=eob69Q0UATMtxXxZTfH8QBgfwrRlRVQwJciZLhGoNbw+B3kcVD6KJDjdVHZjw5EPrrDG
 LxXbk4NEy5/GdBd6k8Tj95KL4c3S+aW3S4Wkc6UDBDb0LrOtq2dmVh/geMOnOB+l+Li9
 HFJSCA9UAlmQDYooGveaF5jGH+ZYkjHmithsfQUzRknxXgU14YJvqw62K/INZAyjRdea
 ttlNLw1BgBxesiyo69sOmrdqBZWrXT8rZ/rRv92LGQ0kN7Q4zhFTYNiwSAdTAFs3xUHE
 049vgPGphb6CZERnioCg5ik6ik2j3PpQiqNtzR1EaawSzMmnhTo4V+tkbteFETW13tI6 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhpg7gwmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 15:11:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40AEKcAJ006729;
	Wed, 10 Jan 2024 15:11:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur5gfbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 15:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1P4e6ff/38JFTJK2czm7A2/RokP0usOv/wGtH3CMmX3lrAG/S8Q94eZ9XlRnkxJVeRNBUx7RBSu1IpZOYlYS/VRZeSLyKUPO9PflCVwRDu8hhyRgztjiVhcRGwJg3jpJPbjgpPXCKbCxZ2+OV62sIwO4dMAJYjclDHHNiUysmlWUswcU9vlyaddva1t3HdKqorCLIwxDoetWD8xgFNP9shi2JTP0qdH/lTPI7KhHTKAmCGHRI6LGpXNetnT7t2QIlb7qsVWFNliJQgp2KunTwopB1Rfnbm2tqAUApz3gaFTsF3Jm+1GUcSN3TXeWdG5hmo1fSuBD/dHMuZjXZfEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vah6pweRH0OHLU+oIdqay7w525l6twRjCqehdMrNL8=;
 b=IKWE05yavZ+B3P8e9RncEyLysmZPUoAgx0O7FLEZHeywduXXu2X2SXJvqboSpOdYGj1YACQxW+ZaDBoEBBnNi97SOKpQg4rkQ0nCawe0uBvpbPPeZ07mCratSMl25s6R+bU33j7LSw3ZYwd1eGOLZ3M60Unt9KnW00eBcUvbBaK3Zmg53a1c6ubz4iKU2pqxrT1MHRmSky+tmCttFoz/5q7C9iHYQ1KZp0pA3C46LVZAMC8h3oHyeqIjC8ALAnZDY+mbKYSShWfRaHLrwMICd3HLb5Yv8em0aoWziprVmTFH5P6dZh+FZPOZnao10UGNwmmwezwslGNgLut0bhoJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vah6pweRH0OHLU+oIdqay7w525l6twRjCqehdMrNL8=;
 b=vXRsq20V7kr5kwoQOO7g9oIXnMg/Iwy5JEQ3rIQLaL4c0CwNC/ON9xeambxvXppwUi0JCVQnFWX5tb0DGcSvhWG71TnzX98AwY28vBBhc48AlV6Y+0cy3AYPnFABHaPvsAQLM0aO9dm9yL4lFQ0KiMbPg0LWMWJrVSKXO6VstIg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:11:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:11:00 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
Thread-Topic: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
Thread-Index: AQHaQbEgd95pfR0KM0OZqULK9pLItLDO77KAgAEN8oCAApUkAIAAmDoA
Date: Wed, 10 Jan 2024 15:11:00 +0000
Message-ID: <B5750E41-D130-44CF-8446-EC71BB149E7D@oracle.com>
References: 
 <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
 <ZZwJLb7j65QXR1+K@tissot.1015granger.net>
 <CALXu0UdJanF-_=3TzgzUskwh1RGPjw+LeZ0Cht+yP1aQgr8v+w@mail.gmail.com>
In-Reply-To: 
 <CALXu0UdJanF-_=3TzgzUskwh1RGPjw+LeZ0Cht+yP1aQgr8v+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6297:EE_
x-ms-office365-filtering-correlation-id: 2b69982a-6f24-47ea-31ab-08dc11ee5b12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7dGCUKSqdh0DyPZy+bLehoBg9OU7KW1BEf0j0LrbCVNnNS9AHm9yD3lI2jiPfoiRYOc2DXKaE8bzazZlX6FeXq3IBmaM30qkarWkxXeoy5GPUI4ir3ff9pRn1qw2Hi/njGBaiq1Bpr4rN0uTQOB9Xcy3vKs7NYq/lKJ91MweA3Fw8nvvak5eVeldmMdCkI5PXiwmX05GPx0P7FiR9kOdtM0x+WEmP+4VpR0U85TJ9Ww855UebqAVJYU5pUhsTib0iU+QPO0vFPBRIs7JILJCL9fEyPOSiYp0z4PzHP+sdKz552w8MztTahUdPFqaCbhmoi5iOmm/FGhbFa1oLmnE1Vz4DiUw58p7YqPA+C+BRaIxWFy4as1nrfZE1j/koCYugGXxpWrjRTjgTscj2wkBKUC2u4/xHLgaTM6fs/EEoWjuq2J23Zuc3xseru68adfXLVErLw/6cVZb3domGpOCHs3TvU/Ixs5cmbK8IPIhtceNE/M+JBvuhBxRNAvUwDaFDsAykm8j/BPfkzDUxTQ2fln8hQTtHEnsr+QMUdRlAv52jLngUJ4s7gbjpzUVrOhfE5IQhFmTxpEqKuZjfNh21DM5AQWGIrXxIXXLx4XeHxx1BYwhYoEODN5elRW7P3S4W7/T1LPdXj/j5DnnIcGzJw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66899024)(38100700002)(2906002)(38070700009)(5660300002)(86362001)(41300700001)(66574015)(36756003)(316002)(122000001)(8676002)(8936002)(6486002)(2616005)(91956017)(66946007)(76116006)(64756008)(66446008)(66476007)(26005)(6916009)(6512007)(966005)(478600001)(6506007)(83380400001)(71200400001)(33656002)(66556008)(53546011)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWVnY2xTODNRdzR2LzBhVWRwSTJtTkN5WUU4bWR3NmxXU2lZK1N2U29nWnJo?=
 =?utf-8?B?SXRBbWFoVTJ4UXpWcktKVVN0RnFwcTd6L1R5MHJ5dHRRUVhrMVNuOHJES3dz?=
 =?utf-8?B?YnFnSjFSRHNrSjZScmYyemVXMUZaQ2VBb2JwQVJjeUlCdnpXbXZaZmozcVUr?=
 =?utf-8?B?YnFsRk9JVWtkMUVwaHE0VGxSZFRnZU4zUEcra2xwZTc1c1E0WVJ1bjN0R1dB?=
 =?utf-8?B?RDR4alJQMXp0dXBhQTJzb0xJeUtBN01ZQW9tUWE2L1NCc0RhMWRXaHpXT2Ju?=
 =?utf-8?B?R3kwd1pNK3FRSXl1aUNITjJraG53djlCQk9GcGRxV2pCdlRFRm9LaFZ4ZHZP?=
 =?utf-8?B?Zml1OUs5OStROTVBaXNLQkxwWWg0NEx6WHhPVFZxeFd0UHl1ZFI2UkczRy9F?=
 =?utf-8?B?dkNnMUtqNGxYMTJVVWh6dzM1cEY3dytyQ3F6YWNMQlVSR1FJSlozSXo5S1Rm?=
 =?utf-8?B?SFhESmgwUWlLWEtNV1pReTZGU0J5V3p4MGVndThRd0dySWJvSDdSN2UrVWEw?=
 =?utf-8?B?VnpPNFpYRThmcjg4NjFqaUw2OWw3NEZ6aTRueXdxOGJLK20xVndpMXhIKy95?=
 =?utf-8?B?RTlEb3dtMFlQNGROc3daWDlpWUFGWTJRa1gwSklmR2U3YzQrc0tkaXRqWGpW?=
 =?utf-8?B?enpMOXYzenozMnhjYWZIYXN4S0U3ZnVlcXJ5a05FRG8yQlprSXhtQXlZWGJO?=
 =?utf-8?B?a2E5N0hqRWNGRDdWcGRsZzRUNnJZQkV2SW5TcnVURzBGTjVnd2FuZjlyU3lx?=
 =?utf-8?B?T2swRDFGWmhLeWtFTUlXM1JQZEFORUVDM2lVRERmU2piaDJ1V1dsSlhmb0NW?=
 =?utf-8?B?VWo5L3BEcFZuWWFDK3loM011bHY4b1lLNERnM2UwUDYrbUdlZTAyVU5FVDlz?=
 =?utf-8?B?MTE2cGlna2pmWTA0NDJsb3l5bk5MWE9aSTN2S1E1SXNnNDBTQ0VSWWNpS0lI?=
 =?utf-8?B?aXJ5T2QzUW5NZVRiaFNpdjJNYjF6bHdHK3A2dzdWYzNLcnZpQUI0RzV3N3Bl?=
 =?utf-8?B?am5kb0VYQVVYc0pPSzJrNmowSkVWVzk4eUNnaVBnaCtsYW4zZW5jczhzUlFQ?=
 =?utf-8?B?K2dCS0l5L3pEeWFLS09HU0FKNXZFelRRNlpvYWUveS95RUJwTlpSVHZtcmRM?=
 =?utf-8?B?VWhBNFF6V2pKT1V5d3FQK2tTanV0NDRTZ0lIMy94dytyL1JqTllWdnNxdUo2?=
 =?utf-8?B?M3BLRmRGclJ2WDBtR2Y1Z1VVZHNCa3lETlFNd1ZaM2xGSFNLTGg0SmozZ0dj?=
 =?utf-8?B?NjU2aTNyaUwwUWJVL2ZuNURFWktiU2I3TnVYL2hnUUFSeUg4Y0Fhdy9wM2pK?=
 =?utf-8?B?azdoZjdkNUw2RndESENsckd3VXRYZ05jNldYdnIwQUU2M1pJTi80Q20zTlJE?=
 =?utf-8?B?c1BncEw2VFJKQVZGWklXbENmamIrMUVDSmpXUDllRXp3dmdHQU9YbG9Sa2Y4?=
 =?utf-8?B?c21LR3B4N0N5Y1I4UExvSXVWL2FBVlNSbk9kNzNuaVMrbjRvWXZiOGtabmtw?=
 =?utf-8?B?YmxWTkcvVjFBTzZEeG9CZEZ0VUhNWnlUTFdhbzM3UDhxaFg0TGR1MUdrL3lZ?=
 =?utf-8?B?bXlneWw5d1dDWndLVjlaSWtRWnZyTE9nNTBJUWZhS04zd0JuZ2RxbXNneGUz?=
 =?utf-8?B?ZXBaeEp6Ni9JVEhwaHlwdUx3S2dGaDJGUXhnNjFIcXEzVnZRWTRob3hqTnRY?=
 =?utf-8?B?QUp3SHFKK3ZXOFp4TDNJanliNzNCcDAwZVcwSjh4SVNCUlhKNC93YWpERnRi?=
 =?utf-8?B?aW0zcmlhc1I2N1JQZ1p0OFV5c2pKZDRrTTNEK2daNGZ3QnFVLzBURUtWY2wy?=
 =?utf-8?B?TTRqTDVEMUtON0JuL0F0SFJXQXIrRkNjYXJlQmdWK2FTTWdSVWw4Z2pFMDVw?=
 =?utf-8?B?MUtMNGhSQUh2eVRzaDNtM3NvaVpTcHZZKzlXYUpwWkkvNzhHWkIybkV2Q0Yr?=
 =?utf-8?B?cWtpUExCNTYzVlE4ZFByTUxlcXl5ZTkyYWVMN1ZLRlpWeiswYkUxN3RPRXQ1?=
 =?utf-8?B?WVdIRENYUzlRRVNnRWFlbUNNT1FuVm1XOUZlN2VtNnNFb3JPdVErT1djbXNK?=
 =?utf-8?B?TmRvTzA1OHgyUXNOVmlhN2dlM2pxVnlxcUVUYW1RTDFDR3FOb3czQnpIeXlX?=
 =?utf-8?B?TFh4NlRhTXBBMlQ3N3JqZUZMdGF2RFZlMjk0MlY2ZTZyRk1PWERadUxKQlQr?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D12BB2B573FB5C42A42DA9715C54A546@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TUnTaumRRoB+JJ8pRGAY+REx1DqlFLl8T/CNIveZKdx3VDxVeVTeNrYFq/moB5fMeZWWOeEun5H/1fvahHo7+GRELFV3Q+YL1iLrcxQBQFUvNs6Ul09Taci3kE9qTUfrAy+595nwUHLNYKkh3hUdDuUqks3FacZw3ECA7Tvd0+LolBiBRJXb2523e07hrkZ07MRrGdaVnP+QCY4ITZtBabcpNf8F3WqgdFHy1etDiwbSP325VNt5U9qhtjkKlwyKyFLXd5VIpfOCJ9hnZcN1XNHGhrjcBZChk2JmNOzcHu9HEEfMHh7qymyqfk31adX9Szorguxf/HLoYdmTSYaia9V4PSd1xjt+ovlw+u7MxSYyE7NfRXPf3UNtXvOHobmhOZMQtdoTgKzAGL6REw7RPh5g6Dk72Saf2itesHD2SUOEN97AFST+nhjZGTJiszbPBM+CDfDujpF/Ex6RLpXHe8H1NWUb5E4JE+lln8V1U+51aa+VpSkseOCRh3tkIWYEMUeoCUrhdQWDHGray9kGFekwlNisZHO9SUn2YJiPR8X/c8v+HZgiACHRKIWQNX445USSq7AuwyE3v33qZMCwJc7tVQ2aHnqCYyMXF47WQFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b69982a-6f24-47ea-31ab-08dc11ee5b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 15:11:00.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQKX8gug3wZl2+aLliEcTjod0fT4M+Zdv3lZ9dZRJvmvRi1kXnJawE2C45OFfEe6MvXy5KrrEkG5KKpNrPbMHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_06,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100123
X-Proofpoint-ORIG-GUID: fnhqXtAbbu5C3kw4PL8kDgfeUmKXBE5S
X-Proofpoint-GUID: fnhqXtAbbu5C3kw4PL8kDgfeUmKXBE5S

DQoNCj4gT24gSmFuIDEwLCAyMDI0LCBhdCAxOjA24oCvQU0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDggSmFuIDIwMjQg
YXQgMTU6MzksIENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4+
IA0KPj4gT24gU3VuLCBKYW4gMDcsIDIwMjQgYXQgMTE6MzM6MzFQTSArMDEwMCwgQ2VkcmljIEJs
YW5jaGVyIHdyb3RlOg0KPj4+IENvdWxkIHlvdSBwbGVhc2UgbWFrZSBhIGNvbmNlbnRyYXRlZCBl
ZmZvcnQgYW5kIGFsbG93IG5vbi0yMDQ5IHBvcnQNCj4+PiBudW1iZXJzIGZvciBORlN2NCBtb3Vu
dHMsIGluIGFsbCBvZiB0aGUgbGlmZWN5Y2xlIG9mIGEgTkZTdjQgbW91bnQ/DQo+Pj4gRnJvbSBu
ZnNkLCBuZnNkIHJlZmVycmFscywgY2xpZW50IG1vdW50L3Vtb3VudCwgYXV0b2ZzDQo+Pj4gbW91
bnQvdW1vdW50K0xEQVAgc3BlYw0KPj4gDQo+PiBPbmUgcmVhc29uIHdlIGhhdmUgbm90IHB1cnN1
ZWQgc3RhY2std2lkZSBORlN2NCBzdXBwb3J0IGZvcg0KPj4gYWx0ZXJuYXRlIHBvcnRzIGlzIHRo
YXQgdGhleSBhcmUgbm90IGZpcmV3YWxsLWZyaWVuZGx5LiBBIG1ham9yDQo+PiBkZXNpZ24gcG9p
bnQgb2YgTkZTdjQgKGFuZCBORlN2NC4xLCB3aXRoIGl0cyBiYWNrY2hhbm5lbCkgaXMgdGhhdA0K
Pj4gaXQgaXMgc3VwcG9zZWQgdG8gYmUgbW9yZSBmaXJld2FsbC1mcmllbmRseSB0aGFuIE5GU3Yz
LCBpdHMNCj4+IGF1eGlsaWFyeSBwcm90b2NvbHMsIGFuZCBpdHMgcmVxdWlyZW1lbnQgdG8gZGVw
bG95IHJwY2JpbmQuDQo+IA0KPiBXaG8gY2FtZSB1cCB3aXRoIFRIQVQgYXJndW1lbnQ/IQ0KDQpU
aGUgSUVURidzIE5GU3Y0IHN0YW5kYXJkcyBncm91cC4NCg0KTkxNLCBOU00sIE1OVCwgTkZTQUNM
LCBhbmQgTkZTIHdlcmUgbWFkZSBhIHNpbmdsZSBwcm90b2NvbCB3aXRoDQpORlN2NC4wLiBPbmUg
cmVhc29uIGZvciB0aGlzIGRlc2lnbiB3YXMgdGhlIG5lY2Vzc2l0eSB0byBhZGQNCk9QRU4vQ0xP
U0Ugb3BlcmF0aW9ucyB0byBtYWtlIGZpbGUgbG9ja2luZyBtb3JlIHJlbGlhYmxlLiBCdXQNCmFu
b3RoZXIgd2FzIHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIG9wZW4gcG9ydHMgbmVlZGVkLCBhbmQg
dG8NCmVsaW1pbmF0ZSB0aGUgbmVlZCB0byBydW4gcnBjYmluZCBvbiBORlMgc2VydmVycy4NCg0K
V2l0aCBORlN2NC4xLCBjYWxsYmFjayBvcGVyYXRpb24gd2FzIGFsc28gY29tYmluZWQgaW50byB0
aGUNCm1haW4gcHJvdG9jb2wgYnkgbWFraW5nIHNlcnZlcnMgZG8gY2FsbGJhY2tzIG9uIHRoZSBz
YW1lDQp0cmFuc3BvcnQgY29ubmVjdGlvbiBhcyBmb3JlY2hhbm5lbCBvcGVyYXRpb24uIFRoaXMg
aXMgcHJlY2lzZWx5DQpiZWNhdXNlIGNhbGxiYWNrcyBjb3VsZCBub3QgdHJhbnNpdGlvbiBOQVQg
Ym94ZXMgYW5kIGZpcmV3YWxscw0KaW4gYSBjb252ZW5pZW50IGZhc2hpb24uDQoNCllvdSBjYW4g
ZmluZCBhIGdlbmVyaWMgbWVudGlvbiBvZiBpdCBoZXJlOg0KDQpodHRwczovL3d3dy5yZmMtZWRp
dG9yLm9yZy9yZmMvcmZjODg4MSNuYW1lLW5mc3Y0LWdvYWxzDQoNClRob3VnaCB0aGF0IGlzIG5v
dCBhcyBkZXRhaWxlZCBhIGRpc2N1c3Npb24gYXMgSSBtaWdodCBoYXZlDQpob3BlZC4gVGhlIG92
ZXJhbGwgZ29hbCBtZW50aW9uZWQgaGVyZSBpcyBnb29kIG9wZXJhdGlvbiBvbg0KdGhlIG9wZW4g
aW50ZXJuZXQgYW5kIHRoZSBhYmlsaXR5IHRvIHRyYW5zaXRpb24gZmlyZXdhbGxzDQplYXNpbHku
DQoNCg0KPiBORlN2NCB3YXMgZGVzaWduZWQgYXJvdW5kIHRoZSBjb25jZXB0IG9mIE9ORSBUQ1Ag
cG9ydCBmb3IgZXZlcnl0aGluZw0KPiAoZnMsIG1vdW50LCBsb2NrIGRhZW1vbnMsIC4uLiksIHNv
IG11bHRpcGxlIHNlcnZlcnMgcGVyIElQdjQgYWRkcmVzcw0KPiBjYW4gYmVjb21lIGEgcmVhbGl0
eSwgYnV0IG5vdCBzcGVjaWZpY2FsbHkgMjA0OSAtIHdpdGggdGhlIGNsZWFyDQo+IGFzc3VtcHRp
b24gdGhhdCB1c2luZyBwb3J0IDIwNDkgbWlnaHQgbm90IGJlIGZlYXNpYmxlIGZvciBhbGwNCj4g
b3JnYW5pc2F0aW9ucy4NCg0KSSd2ZSBuZXZlciBoZWFyZCB0aGF0LCBhbmQgSSd2ZSBiZWVuIGFj
dGl2ZSBpbiB0aGUgTkZTIHN0YW5kYXJkcw0KZ3JvdXAgZm9yIG1hbnkgeWVhcnMsIGFuZCBoYXZl
IHdvcmtlZCBjbG9zZWx5IHdpdGggdGhlIGF1dGhvcnMNCm9mIHRoZXNlIHN0YW5kYXJkcyBhbmQg
dGhlIGZvbGtzIHdobyBjcmVhdGVkIHRoZSBpbXBsZW1lbnRhdGlvbg0Kb2YgTkZTdjQgb24gc2V2
ZXJhbCBwbGF0Zm9ybXMuDQoNClNvIGlmIHRoYXQgdHJ1bHkgd2FzIGEgZ29hbCBvZiB0aGUgc2lu
Z2xlLXBvcnQgZGVzaWduLCBpdCBoYXMNCm5vdCBiZWVuIG1lbnRpb25lZCByZWNlbnRseSwgYW5k
IHRoZXJlIGFyZSBjZXJ0YWluIHByb3RvY29sIGdhcHMNCihsaWtlIG5vIGV4cGxpY2l0IHBvcnQg
ZmllbGQgaW4gdGhlIGZzX2xvY2F0aW9ucyBhdHRyaWJ1dGUpDQp0aGF0IG1ha2UgbWUgZG91YnQg
eW91ciBhc3NlcnRpb24gdGhhdCBhbHRlcm5hdGUgcG9ydHMgd2FzIGENCnByaW1hcnkgcHJvdG9j
b2wgZGVzaWduIGdvYWwuDQoNCkJ1dCB0aGlzIGlzIG9ubHkgYSBzaWRlYmFyLg0KDQoNCj4gSWYg
eW91IGxvb2sgYXQgU29sYXJpcyBCVUdTVEVSIChyZW1lbWJlciwgd2Ugd2VyZSBhIGJpZyBTVU4g
Y3VzdG9tZXINCj4gaW4gdGhlIDE5OTAvMjAwMCwgc28gd2UgaGFkIGxvdHMgb2YgYnVncyBvcGVu
IGZvciB0aGlzIG1lc3MpLCB5b3UnbGwNCj4gZmluZCBsb3RzIG9mIHJlYXNvbnMgd2h5IG9uZSBz
aW5nbGUgcG9ydCBmb3IgTkZTIGlzIG5vdCBmZWFzaWJsZSBpbg0KPiBhbGwgc2NlbmFyaW9zLg0K
DQo+IEp1c3Qgc29tZSBleGFtcGxlcywgYnV0IGNlcnRhaW5seSBub3QgbGltaXRlZCB0bzoNCj4g
LSBGaW5lLWdyYWluZWQgSFNNLCBhbGwgb24gb25lIGhvc3QNCj4gLSBGaW5lLWdyYWluZWQgcHJv
amVjdC9yZXNvdXJjZSBtYW5hZ2VtZW50LCBpLmUuIG9uZSBuZnMgc2VydmVyIHBlcg0KPiBwcm9q
ZWN0LCBhbGwgb24gb25lIGhvc3QNCj4gLSBDb21wZXRpbmcgdGVhbXMNCj4gLSBIb3N0aWxlIElU
IGRlcGFydG1lbnQgKGUuZy4gcG9ydCAyMDQ5IGJsb2NrZWQgb3V0IG9mIEZFQVIgLSBub3QNCj4g
cmVhc29uLCBubyBmdXJ0aGVyIGRpc2N1c3Npb24vbmVnb3RpYXRpb24gcG9zc2libGUpDQo+IC0g
TkZTdjQgdHVubmVsZWQgdmlhIHNzaA0KPiAtIE5BVCwgZS5nLiBwcml2YXRlIElQdjQgYWRkcmVz
cyByYW5nZSBpbnNpZGUsIG9ubHkgb25lIElQdjQgYWRkcmVzcyBvdXRzaWRlDQo+IC0gSVB2NCBh
ZGRyZXNzIHNob3J0YWdlDQo+IC0gU29mdHdhcmUgdGVzdCBkZXBsb3ltZW50cyBpbiBwYXJhbGxl
bCB0byB0aGUgcHJvZHVjdGlvbiBzeXN0ZW1zLCBvbg0KPiB0aGUgc2FtZSBtYWNoaW5lDQo+IC0g
Li4uDQo+IA0KPiBJbiBhbnkgb2YgdGhlc2Ugc2NlbmFyaW9zIHlvdSdsbCBlbmQgdXAgd2l0aCBO
RlN2NCBjZXJ0YWlubHkgbm90IHVzaW5nDQo+IFRDUCBwb3J0IDIwNDkuDQoNCkluIG1vc3Qgb2Yg
dGhlc2UgY2FzZXMsIHRoZSB1c2Ugb2YgYWx0ZXJuYXRlIHBvcnRzIGhhcyBiZWVuDQpzdXBlcmNl
ZGVkIGluIHRoZSBwYXN0IDIwIHllYXJzLiBJJ20gbm90IHNheWluZyB0aGVyZSBhcmUgbm8NCmxl
Z2l0aW1hdGUgdXNlcyBmb3IgYWx0ZXJuYXRlIHBvcnRzLCBvbmx5IHRoYXQgdGhleSBzZWVtIHRv
DQpiZSBpbmNyZWFzaW5nbHkgYSBjb3JuZXIgY2FzZSwgYW5kIHRoYXQncyB0aGUgd2F5IHRoZSBM
aW51eA0KTkZTIGNvbW11bml0eSBoYXMgcHJpb3JpdGl6ZWQgdGhlbS4gKEFuZCBpbmNpZGVudGFs
bHksIHRoZXkNCmRvIG1vc3RseSB3b3JrIHRvZGF5IGluIExpbnV4LiBUaGVyZSBhcmUganVzdCBh
IGZldyBtaXNzaW5nDQpzcG90cykuDQoNCkxvb2ssIHlvdSBhcmUgcmVhbGx5IG5vdCBoZWFyaW5n
IG1lLCBjbGVhcmx5LiBOby1vbmUgaGFzIHNhaWQNCm5vIHdlIHdvbid0LiBXZSBoYXZlIHNhaWQ6
IHRoaXMgaXMgaGFyZGVyIHRoYW4geW91IHRoaW5rLCBhbmQNCmhlcmUgaXMgd2h5LiBXZSBoYXZl
IHNhaWQ6IGlmIHlvdSB3YW50IHRvIGRvIHRoaXMgc29vbmVyLCBoZXJlDQppcyB3aGF0IHdlLCBh
cyB0aGUgc3Rld2FyZHMgb2YgdGhpcyBjb2RlLCB3aWxsIGFjY2VwdC4gV2UgZG8NCmhhdmUgYSBw
bGFuIGZvciB0aGlzLCBhZnRlciBhbGwuIEp1c3Qgbm90IGVub3VnaCB0aW1lIHRvIGRvIGl0Lg0K
DQpUaGlzIGlzIG9wZW4gc291cmNlLiBJZiB5b3UgaGF2ZSBhbiBpdGNoLCB5b3UgY2FuIHNjcmF0
Y2ggaXQNCnlvdXJzZWxmLiBZb3UgZG8gbm90IGRlbWFuZCB0aGF0IG90aGVycyBpbXBsZW1lbnQg
d2hhdCB5b3UNCndhbnQsIGZvciBmcmVlLg0KDQpXaGVyZSBkbyB5b3UgdGhpbmsgdGhlIHJlc291
cmNlcyBmb3IgZGV2ZWxvcGluZyBuZXcgZmVhdHVyZXMNCmNvbWVzIGZyb20/DQoNClBsZWFzZSBz
dG9wIGFyZ3Vpbmcgd2l0aCBzdHJhd21lbiBhbmQgd3JpdGUgc29tZSBjb2RlLg0KDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg==

