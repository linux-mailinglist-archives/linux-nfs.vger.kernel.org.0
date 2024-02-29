Return-Path: <linux-nfs+bounces-2125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAC86D5FD
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 22:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA4F1F232B4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 21:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096C433B3;
	Thu, 29 Feb 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="HJ2VqNcx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02on2104.outbound.protection.outlook.com [40.107.91.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B041C77
	for <linux-nfs@vger.kernel.org>; Thu, 29 Feb 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.91.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241406; cv=fail; b=WNaVSuBUL7jnLuAGLs1bu62NfN7Jt701GuDjh5/XrTfBeMWzT3MVc9j2y9UXu5s95+BEvNXcldC/y0lkmc5gVnfl9KNgtip9z6ejZij1x8ftUuWOfuZqRDbVPLHnqh2T4xhxsJLasAJiL/AzwIBZlAaTcmvwCMO/s6KFcSDtY8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241406; c=relaxed/simple;
	bh=/AL6VyMoSlrjNUQEFc8PVafnLkLG8TQb0vqC0NA/xxU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=LsCzHeGulCW9f/fWoSqb23aXYkgZ/kxTLHhxKNVW6E9Rh0qaBMtOvLlYZtZyDQkcH7jkS7aNOFB9k5y6T/AT+byQp7jGVx3qlK4Gm2DY7ZwIO2bp1CCy45KMJRP53anChw4Ds8X+bTn/rnxrOLmPs1mZJMywJCP2O9nNhLsggOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=HJ2VqNcx; arc=fail smtp.client-ip=40.107.91.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPz4JocQTmDoel+3ErvFANpm5ZPGALMoJcNE7eGm/L9uZ1GrdbVkc6eJK2VHM93sJ8lVYqnE1RgSED5W0O5JJT/Y3NSLjG5PDIm+uKBUM+EMaVF2x01CSuAieAkcuSqgzOlf9SdxGQwlxAluT2S4d/sRdhfjjJafgsElwtoWT6TaOiGJqg3v5Mb6owsnW4H5jrwk0rP4n7ndKU0Lv/X/NjusJaCRQBMSXA2d37qhptrRiB57Of8Og5cZKCcGgJ2CENLhTjvVQhyIDj4fImEkVCMEWKSAjyYoo1n6kda4pHFVdt2jwD0it0ZqTKzeo/Wjqx7B98wFHqxCssjVOvQVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvY5DCP2bBtFXYZpgHQxkyqE7i5Mdn0d6SGyaJvlu7M=;
 b=D4INAO7Fm2zflNwvxKwwvR6PWWsz/mp0gLfFGZFH61tYWoFtF659wVfSeBRF7tM/PKmFS7SeQRlQ93yjuG7HeRIQUjmNIQcsqwt7tnVZ6me+zOdO2WLFKj6s60l8438hVkoeBfQzZlmQvcFZW1wR0H2jcr+gXJ9iOHuq/Zhf//02dmbtbvFw56TFXplY52VK+s528BG3iB0jWnK9PHx8ljmm2Sbv6QyOD5Gv6ud2pQXtVcq7GYJBvCcH2WjA+fjDjPiPTIO/no/XX5kO4eycZiSaw0IYznnk6CQYo5jpRBV8BmGSbkmhhCaLhXYY8XL7enM11Soimw03Gsbjmhlzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvY5DCP2bBtFXYZpgHQxkyqE7i5Mdn0d6SGyaJvlu7M=;
 b=HJ2VqNcxKUAhJM2DJFnW4ldueNljwT9YledI1gvaiGx3THmZceVaa5aR5gnAPZ1/smCvCrTyro8Rruy20BurAul3jMtFbK5XZku7YIu8HTkSGIe+4BxzaU3dEyG5L3qpwk/As5LzESvvtBkas43SOkjwaeYY8EDyK/Oc/sqKagaEKwEJbClsi6e74mZ1F0G/oAgdlivykNOxNKHpvewKqpJ9/WJomGxxV+cCMIf+xzn3PgVLQ4n4DMdXLXunbAmKtCAAAavzu5yBHBqTVgW8SJVkIcy0JSQsCU0bAgVrWb3b8qchIgjoe4rJBegasN1f0T9mY2CEUWpVMTd/hxvY+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from MW4PR09MB9632.namprd09.prod.outlook.com (2603:10b6:303:1f8::17)
 by SA1PR09MB9763.namprd09.prod.outlook.com (2603:10b6:806:286::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 21:16:41 +0000
Received: from MW4PR09MB9632.namprd09.prod.outlook.com
 ([fe80::8d34:e911:1a99:5242]) by MW4PR09MB9632.namprd09.prod.outlook.com
 ([fe80::8d34:e911:1a99:5242%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 21:16:41 +0000
Message-ID: <8b16410b-6b2b-406e-a669-41abee137932@nwra.com>
Date: Thu, 29 Feb 2024 14:16:38 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: Orion Poplawski <orion@nwra.com>
Subject: Cannot initiate mount with sec=krb5 as root from EL9 clients
Organization: NWRA
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080606080702070409050502"
X-ClientProxiedBy: CY8PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:930:45::11) To MW4PR09MB9632.namprd09.prod.outlook.com
 (2603:10b6:303:1f8::17)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR09MB9632:EE_|SA1PR09MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 4edb8f73-3aa8-4aaf-bf20-08dc396bb93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UXuaC4Vis7Hpp7pzst9gcU4tPlwKJtRfhv/QBL1wj5XbrOOBT924c0mFuR04THbsrX3YfqLgA3bSLX1U4ppgoJzu38wMJBmbhorO4+HmYDM2hzEo6BvSuntCAeIzOZJ6i6uJHQT0/wYGdZq/CYSCF5C6uij8cY65VVJYNcmuzPxNseKL5iAZMuguN74ovykJKNloCtkFzj6N4jRxqUT/Cvt57EWm5Do1ruGK9HHX2DBlpdnCT/tEFF8N5JfCX7uwB6I7ROJr5OIMOiuwD6x0hZO9eOmUSU+J0ovzQ542LP33nAIflHPWS6ztTrwZE6wfzBPg2OeSXb/JBimY2jsYe/4BzpQ3x5eZvHfsHDaRoShOSwCsgRnoa3igg7qPdtjYNtzR/Kby/nuf5rJo0TzqjxTr/4JJa0n9sq3G+gJZXqP6QB5RzbuzC6GrsU13uoczV5/fE/uiMFDAzPoyIp4nuMXtiFfW/ubuVkGbzWd4jezwwmKXZXSGiuU06lFqngvpuieukUOvPtDMT/SOTgZSICiK68Z65PDOCNYimfMKLA5GCJbtPZDwcaoROSULwpLT0ovsZ4+cTLr7zTQK40nxWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR09MB9632.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmcxS0k1M0ZWdHpCck9Mci9lUU1hSlpzOXdKeUlaS2VEVitZWnZJcWsrL1hn?=
 =?utf-8?B?d0tZRHV3bTEzVmFCSzN5RE1VWm0vWnVuRUl2YXlxTStxcmNFVWVsQUVlMG9v?=
 =?utf-8?B?VS9NRDBTZkNsSWRqOEphR1JuNjdsVlZYUjJra1cxTHMyQTFJSTJFMUtFci9R?=
 =?utf-8?B?WWszN3lsK0xJRm85eXE2dlo5bExiemV2ck9jQXh2Z2dPdXJYY1JSSW82TUhp?=
 =?utf-8?B?VVkwcmgwVTdqVHc4WVBsOWQvb2ZEeFJsNmplQzk3bzR2dEZFUVFvdWxqK0FK?=
 =?utf-8?B?b3VlWFF4Qzl2cnExNDgyaHovLzlvMkhSbkdoR3dLSExzWTZnb2NPeTl3MXI0?=
 =?utf-8?B?cDA1cUZYYm9ybDJLOHo2c0loeDdUQzFQRW8ra2FYMmxneGZtOHdsSFhSS1Aw?=
 =?utf-8?B?ckpCUm00RlVqaE1rdEQxZXhPSkdpZHMwTkpjUDF3K1Q3WWdkazBtTnBBNEhI?=
 =?utf-8?B?UWR6MjR5Y05VZ0sxZERGM2YycEdEYXNBWmpyY0pxTGJON2VRbEdJUEJ0L0ZP?=
 =?utf-8?B?N3ArTExYOUxFVVFpaktOWURvSHNDakRzZ1FQMDBFUWM2Ujh4TjQ3L0VCeGdT?=
 =?utf-8?B?NHVFeG96a0Y5bFpDbjQ3L3htbXE4R1kzNUx2V0szeFNBWm1oMElZeGUxK2k1?=
 =?utf-8?B?NFVwY09Rb2taM0wxNlU3WEc2RE5HYkZHa1ZiRE0rdDFEMGxvN085K3BVTTMy?=
 =?utf-8?B?VDYwS1I5RFZmemVma3RYQnZjc3V5TE1WbzFKNVJVVnluWi93UXdyYTlPTk53?=
 =?utf-8?B?M3BXcUFkUmFxcThMb0R2a1g0eHZ0MjAzMlhWV3Z5UWhxbU9CbGxuMzM5Ung1?=
 =?utf-8?B?QlpBYnZYVzFYTjlkRHhuVjdENHJWK3gxSklNKzlmNXRTZUxBRmh5cE1WTGJw?=
 =?utf-8?B?Wmc3bFhwU0h6a2RCTklaUVkrM0JWTkU2WFByVFVUemd6VEFZVGpnSENyUkdS?=
 =?utf-8?B?MjBYU0lXRDUyS0tqZ3NaNUgyUUpGSkVpeE9yY1BTWG5janFnbVhGWVB2RVdj?=
 =?utf-8?B?cENiK09wMEQ4WnNMa0NCNVI5d21EaTZOTFFHSE9QcUNNZEZMbDZtZGRwTFFa?=
 =?utf-8?B?YUhvRUVTdFVsdjJBNlRUSmtrK2p0Z2JwYTNCRTh5TDZjOVJJUC9CNmZ6dm9N?=
 =?utf-8?B?d1c5aElQTHdLVXhtc0x4OXU4UUYrTEc5RDVjc2JkLzBwNUZYdk5DTmVDT3RI?=
 =?utf-8?B?WHZNa0EveVhIeElTejFMcjVJNmszdnJtQ3JjVjVDSlpTZ01VY0FxVWlZSWpE?=
 =?utf-8?B?WnpYR3RnZGROV0h6dXlLbFZvbHREU1RadzZuM01OUStyaDJ4VDZ0aEpBL3JO?=
 =?utf-8?B?U0kyTXlYRFNFalZ1bGl2MlU2ZGJkMWhaUWVyOTFNamVBWkFGSGxaaGVpYUEr?=
 =?utf-8?B?OWZ3R1o2K1pvcmE3eGJYS1doTDNHRkM0ZjdjempRb3N2OUhGa0QvcE5GQjli?=
 =?utf-8?B?dnA5QWlaVm16NmQ0Tmd1ZjdOanRhcGVoeExmczMxSUpjRklSMmJtRDRKRkxF?=
 =?utf-8?B?QVNjbWlUM1lVakZkZW95NG55VnNvdHZ3YXlVRDlESGVFZ1d3dlh0WmZ1Qmwx?=
 =?utf-8?B?RkV0NWp1UzBiU1BrWTA2Y04vYTl4dXA2dmY2NzhSdDZqZlJ6UHpBMTdnSisw?=
 =?utf-8?B?ZWpvZTI0QVUwQUswdkRjNFEyTlZJTmZpMVFXbFpFaVhSNkYya3JaWFB6T2lY?=
 =?utf-8?B?TzJTaWorcXExZFNieVhncnYwWHZLb3g3WjFUd041NmdoWDM1MU9CM0FoOGdG?=
 =?utf-8?B?RWNFbFBLU0J6Q0ZZYmZMa040SEgzZHVVTmUwMlJkSk91bzhreW53SDA2RHNF?=
 =?utf-8?B?RE1mejlRajhyZExKK09yYmZ0dUVxaDM0VFhJVjdnc3VXN0txSVhsNXp4TFNm?=
 =?utf-8?B?Q1JpVCtYbmlMMkRaWWo3S3k5TldabHRCbHFLUXBnSTBOMFJjTHRLSVFtMkFz?=
 =?utf-8?B?Z0ROYml2SnZDcDEraWpQVU5tTG1xVkV2d3c1OVNENUdHZkdLWkEyQStWN1o2?=
 =?utf-8?B?R2JNdy8ycnhGblEwbW4xUHBUNWErb3VYYzMzU2Mrc3lMeHpSVkNYQVNlajFQ?=
 =?utf-8?B?TnZ1bjZtNmdzLzZzeVJrOVFJWjl2L2cvckNqdFc3Q3lYWnpqQm5KUGUvZVlV?=
 =?utf-8?Q?cQRgvuMDBMouh6vKRB4zV1vx0?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edb8f73-3aa8-4aaf-bf20-08dc396bb93d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR09MB9632.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 21:16:41.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB9763

--------------ms080606080702070409050502
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We are starting to add some EL9 clients into the mix on our network.  Autofs
mounts are working fine when initiated by a regular user, but they are failing
when initiated by root.  This works fine from our EL8 clients.

Client:
kernel 5.14.0-362.18.1.el9_3.x86_64
nfs-utils-2.5.4-20.el9.x86_64

Keytab name: FILE:/etc/krb5.keytab
KVNO Principal
---- --------------------------------------------------------------------------
   1 host/client.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
   1 host/client.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)

Server:
kernel 4.18.0-513.18.1.el8_9.x86_64
nfs-utils-2.3.3-59.el8.x86_64

Keytab name: FILE:/etc/krb5.keytab
KVNO Principal
---- --------------------------------------------------------------------------
   1 host/server.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
   1 host/server.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)
   1 nfs/server.fqdn@NWRA.COM (aes256-cts-hmac-sha1-96)
   1 nfs/server.fqdn@NWRA.COM (aes128-cts-hmac-sha1-96)

Client rpc.gssd:

rpc.gssd[778]:
                               handle_gssd_upcall(0x7f15a0299840): 'mech=krb5
uid=0 enctypes=20,19,26,25,18,17' (nfs/clnt3)
rpc.gssd[778]: start_upcall_thread(0x7f15a0299840): created thread id
0x7f159f1fe640
rpc.gssd[778]: krb5_use_machine_creds(0x7f159f1fe640): uid 0 tgtname (null)
rpc.gssd[778]: No key table entry found for client$@NWRA.COM while getting
keytab entry for 'client$@NWRA.COM'
rpc.gssd[778]: No key table entry found for CLIENT$@NWRA.COM while getting
keytab entry for 'SRV-MRY01$@NWRA.COM'
rpc.gssd[778]: No key table entry found for root/client.fqdn@NWRA.COM while
getting keytab entry for 'root/client.fqdn@NWRA.COM'
rpc.gssd[778]: No key table entry found for nfs/client.fqdn@NWRA.COM while
getting keytab entry for 'nfs/client.fqdn@NWRA.COM'
rpc.gssd[778]: find_keytab_entry(0x7f159f1fe640): Success getting keytab entry
for 'host/client.fqdn@NWRA.COM'
rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating tcp client for
server server.fqdn
rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating context with
server nfs@server.fqdn
rpc.gssd[778]: WARNING: Failed to create krb5 context for user with uid 0 for
server nfs@server.fqdn
rpc.gssd[778]: WARNING: Failed to create machine krb5 context with cred cache
FILE:/tmp/krb5ccmachine_NWRA.COM for server server.fqdn
rpc.gssd[778]: WARNING: Machine cache prematurely expired or corrupted trying
to recreate cache for server server.fqdn
rpc.gssd[778]: No key table entry found for client$@NWRA.COM while getting
keytab entry for 'client$@NWRA.COM'
rpc.gssd[778]: No key table entry found for CLIENT$@NWRA.COM while getting
keytab entry for 'SRV-MRY01$@NWRA.COM'
rpc.gssd[778]: No key table entry found for root/client.fqdn@NWRA.COM while
getting keytab entry for 'root/client.fqdn@NWRA.COM'
rpc.gssd[778]: No key table entry found for nfs/client.fqdn@NWRA.COM while
getting keytab entry for 'nfs/client.fqdn@NWRA.COM'
rpc.gssd[778]: find_keytab_entry(0x7f159f1fe640): Success getting keytab entry
for 'host/client.fqdn@NWRA.COM'
rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
rpc.gssd[778]: gssd_get_single_krb5_cred(0x7f159f1fe640): Credentials in CC
'FILE:/tmp/krb5ccmachine_NWRA.COM' are good until Fri Mar  1 10:39:34 2024
rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating tcp client for
server server.fqdn
rpc.gssd[778]: create_auth_rpc_client(0x7f159f1fe640): creating context with
server nfs@server.fqdn
rpc.gssd[778]: WARNING: Failed to create krb5 context for user with uid 0 for
server nfs@server.fqdn
rpc.gssd[778]: WARNING: Failed to create machine krb5 context with cred cache
FILE:/tmp/krb5ccmachine_NWRA.COM for server server.fqdn
rpc.gssd[778]: ERROR: Failed to create machine krb5 context with any
credentials cache for server server.fqdn
rpc.gssd[778]: do_error_downcall(0x7f159f1fe640): uid 0 err -13

mount.nfs4: mount(2): Permission denied
mount.nfs4: access denied by server while mounting

I don't seem to be getting any useful information from rpc.gssd on the server.

Please include me in replies.

-- 
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms080606080702070409050502
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ClEwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggU0MIIEHKADAgECAhBOGocb/uu4yQAAAABMPXr3MA0GCSqGSIb3DQEB
CwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBMB4XDTIzMTIxNjIxMTUyNVoXDTI2MTIxNjIxNDUyMlowgbAxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdTZWF0dGxlMSYwJAYDVQQKEx1O
b3J0aFdlc3QgUmVzZWFyY2ggQXNzb2NpYXRlczEbMBkGA1UEYRMSTlRSVVMrV0EtNjAwNTcz
MjUxMTUwFgYDVQQDEw9PcmlvbiBQb3BsYXdza2kwGwYJKoZIhvcNAQkBFg5vcmlvbkBud3Jh
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKn5wO5Bjob6bLDahVowly2l
AyCWBHGRq1bSptv7tXpj+Xaci4zpCqRoyqX0Gjpo8BEulUYQK8b7nO7UM3aMLC8H6vyzQ64A
GupPGIKuJg+Qr8jA0ihCVH+duE0bNXfDPTm/8VsXOubmVLPLp0cejxzrEC/RI5l8rdl0sQ+2
QZp9jTlyghB1Rxt2AYVYhVVnRMSJ8RgKp9MLV3qIfHqF1k5MGBIP6rS1afmlGd/yW9IWSB8z
iASPtr/Ml5ObbxtYZG47kCKCS7RF2rI6rGNmK/R6cITRs37dzUfBmagDFV897wAW3tHTyLQM
4vobhmS2UYi8C5voc+I75LYOsvLaXHUCAwEAAaOCAVEwggFNMA4GA1UdDwEB/wQEAwIFoDAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYI
KwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkG
A1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLe
a5skMB0GA1UdDgQWBBSZhCz4u7bZ2JjPtNAM8gx3QVEp1zAJBgNVHRMEAjAAMA0GCSqGSIb3
DQEBCwUAA4IBAQA2L6VG0IcimaH24eRr4+L6a/Q51YxInV1pDPt73Lr2uz9CzKWiqWgm6Ioh
O9gSEhDsAYUXED8lkJ3jId9Lo/fDj5M+13S4eChfzFb1VWyA9fBeOE+/zEYrSPQIuRUM324g
PEm8eP/mYaZzHXoA0RJC7jyZlLRdzu/kGqUQDr+81YnkXoyoKc8WeNZnSQSL+LqRvPJCcCTu
JbCdd7C8zYW1dRgh4d9hYooUSsKTsSeDoRkFyqk4ZH0V3PFqa2HiFrdi8h3vpBX44VFddyaa
e+ekomLvvVZWGtJgXWr6VEBo8PTah0fw8BQjCIfFym44D9dulz1YW7E6FRPMSZ7x8X3UMYIE
XzCCBFsCAQEwgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJYIZIAWUDBAIBBQCgggJ1
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyOTIxMTYz
OVowLwYJKoZIhvcNAQkEMSIEINzZOwuu1DrXXzh658/kkuaTHjsTi3RO4Gnlm2INVqGVMGwG
CSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgw
gcsGCSsGAQQBgjcQBDGBvTCBujCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3Qs
IEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5
IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZ
RW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQThqHG/7ruMkAAAAATD169zCBzQYLKoZIhvcN
AQkQAgsxgb2ggbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJKoZIhvcNAQEBBQAEggEA
W8XLZHs4OSf9arkVTflUI7HWQCw5woLd/2PRmxhlhmW53ngVXltyOc2gKfJ+GJeqHReVsJDo
2D/kfASKb/YkGacAKba0ceBOZk74fwWXLZSMbvP9aopIGB7naYuaajWfMs7sfhC6J0BKBTn4
HTCua3pwYEj7pdZuDTFs0flq1ud12hGvMj0ib+fANoKyVaH5E8sGW/2Ji2xtkUG8UxKjWkR6
8kVUZ3aXtXywbts85ny6dbJpAvSTVf9zU8MG3yTsYpj01CcKdBBjwNGtIkfLOPjgJahmFtsR
stbmpVJmJNWtav5ZpK8Aj5UE+5TYuNuxh5NbfrvzfI81azYdwFSVngAAAAAAAA==

--------------ms080606080702070409050502--

