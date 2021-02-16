Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6733531D26A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 23:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhBPWFM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 17:05:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBPWFL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 17:05:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GM4NQ5134735;
        Tue, 16 Feb 2021 22:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : mime-version; s=corp-2020-01-29;
 bh=a0qob9988aXz0b9PbdGXxF0vLpXY+eUHg35OUsIgW9I=;
 b=QIdYmtu1kdugNgEGHRNRCLa5j6g/gNAI/P77YtGZCHYmDjj1BcRnsLe4GW2XHB1EvZBZ
 la2tBmZtyvsQLClyaZeGpKYjfsq8SMp8P8sSlcccIpVseBQo+E71YeC1tyViVnSoi6+G
 umVi3qLqdfeL+LAc+SDQoxO//eQqLHNYwNzUHqPYgNoIE13cTXfMktGweEQLSfh6JP2L
 jU3dA2IikADalDg3xTcSo5ja0cyzxsJD3P+JzmK4Gs1c6eyNAfDRAjHsVFyjITYy/GCa
 aUmjoDljiWfDK+ynlYncOzfYufHmLuZkeJCBszH51D+c29k5r3HEkmQA1fbYUjIYYmu4 /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dngcma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 22:04:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GLtXLO115036;
        Tue, 16 Feb 2021 22:04:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 36prhs3ksy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 22:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4TR3OrOoFpuaUQuFm3ye0Y5dpQN/LkP3bGFaJAV7Neo7FSI0pweVW0/3LUPwn9emYB4+9AG2u5DWHPJZ4L+V+HqZvDiI+6OQAz8HzQDVpkL1royO8Q/OIdu0F1Cl4LHyrrffj5LfuTQjieenqBVEIHdQCw42GqxiZa8X64iVpv2YivBr0iSIt3f9N0mbV8mOWuCVKlTKZDLs3UptINSBfSrvQgypYWyaWSaOMB803GdbjfchCBTqkpxcqskhSuqKh8JGwhFCZPkyzO8PqgzNnRkXRhvrGtZsUvmX5lu3c35EynA7CO1Z4NiuMoLeNN7DdTAaxsfs99gCXWHSn66Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0qob9988aXz0b9PbdGXxF0vLpXY+eUHg35OUsIgW9I=;
 b=C+o8wfuCqnuTIbk7o6FmtYjMxT/XH9wu3525hyRZ95teTtznEDVPIqGo+0tWwiB+ZJKwhOM4+XSxohlfy4TviTa3bbxXoOzUogf/2nY51PrGC5X/EQphCZns7wWj3/+L/vAWJrsYqW9vkTVRP9ZyI7AkxnsTD8R0DwSUAyHWe+gBBTKGMd/W/OpiRc4YRSHU70+D/bqjSIehW7uVEYycis0VadmuKOb4kBtYYAh74N3JtV4ZyE2Jl8a/zizOhT1IFuilcxeNSj4rgUlh0XPuSJsZUlWCoilOrCKb9teNyp+cDehyDOwidjZlWJjkjlbTxqRvxw3QR+PjO4WWt1K8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0qob9988aXz0b9PbdGXxF0vLpXY+eUHg35OUsIgW9I=;
 b=LAtUFS11t4hadywbdikpYZobMbR5PGP8I27sM8Lf7ROAzKkwuadsoiEvzq2Z0KJexFSEE30Rt4DAbXN5Rpi90lxI4q49nfmZH6IcdUoA/ax2wm+13rQWcw9nsta07WGx5TEYHVIfU3YGsE/bmHwTpBH37P+v5fuS99psyHg5Fds=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15) by CY4PR1001MB2213.namprd10.prod.outlook.com
 (2603:10b6:910:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 16 Feb
 2021 22:04:11 +0000
Received: from CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2]) by CY4PR1001MB2119.namprd10.prod.outlook.com
 ([fe80::848c:1057:dabd:55b2%7]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 22:04:11 +0000
Message-ID: <47d31c15-7467-6abb-9e62-96ffca1c6ec0@oracle.com>
Date:   Tue, 16 Feb 2021 22:04:05 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0)
 Gecko/20100101 Thunderbird/87.0a1
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Content-Language: en-GB
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Subject: [RFC] pynfs: add courteous server tests
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NfzQdLJiLupm9ibYaXydn4rs2MYDq6YF1"
X-Originating-IP: [90.243.38.146]
X-ClientProxiedBy: LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::7) To CY4PR1001MB2119.namprd10.prod.outlook.com
 (2603:10b6:910:3f::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mbp2018.cdmnet.org (90.243.38.146) by LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13b::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36 via Frontend Transport; Tue, 16 Feb 2021 22:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f157707-7927-4b67-3de0-08d8d2c6c9e2
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2213D5A2D85666CB4EA273BDE7879@CY4PR1001MB2213.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cNe2WD9Ja4EXfGtgUP4j0Rv2k+87Q6uaMG90pQEcOimp3K2kbLRUfHRrXpD+wj9JDhBSt8Qw44Byp4W9i6X3HDE/WE+EcLL/320WO2nuIg4mxbTHooNRte5Fg/pQNZVZi4J29B/nEuViI0PorgODfVwZ5H8fLmOXb5ck/P4iiHikAD/z/K9G4u90EHZplpqQcF511bAMNrtPzPvjxPwRByeONNZIBryJ6+IV+/OZduyXodNgscfhRPXVndU6FnixQGEwLKBco2dFs6mFkXDeyo2Cxol/IE9/0R2cC8GVIGEYqr99kHNoHQMsiiwOl9FT+IFscmCHeDW0foV0Kb+cCQ/qPMTsYx5sLrnKCwkLlrOQ8w/tZPJn/z8SEPiG9OgZGiVQNSQAZBQYbCPT27rGxsB62NqixoxRGI/aXy7y9w5amn5b8TBqxwSQHpCg7POHJ8dfkG4plpSygPWJNPYooJOqEDpu1uxoUQxxhzUfKq2RuGGGbp80IrXyHF+/ZyoP0aEKla55t5lQlUSwveG0z3ef1w2zAM1uLf89LDrlVo7QQDtNvyoMfOkQnUG9ROTfmP+jcnnaL+5mCd+lRX11xDvnzF+CwJFP5FD4A9Rmj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2119.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(2906002)(21480400003)(6666004)(6506007)(6486002)(16526019)(186003)(66946007)(4326008)(33964004)(8936002)(66556008)(66476007)(83380400001)(36756003)(44832011)(6512007)(31686004)(6916009)(36916002)(31696002)(316002)(2616005)(8676002)(478600001)(5660300002)(956004)(86362001)(235185007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q01yaENIL3ZpVnFFV2FnQzQ0aVlESzF0MHZBTzQyNy9IRnpjdmQxdlp0VVhD?=
 =?utf-8?B?OFAzUWx2L3I0VmdseGtLMERVYm9iWXh5SFl6VVJTaDRyNjBrK3JYR3ZXdjBW?=
 =?utf-8?B?R2s3RnNEVDdEUEVVbEt1elpUNjA0UEhNWmZVQW80dWVSWGw4RU5lMkZOeWNa?=
 =?utf-8?B?clRtSHBKUDRJNktXeTBSa1UraXYzUmVScktGNVQza0l0SGFseldBUUdoVmdQ?=
 =?utf-8?B?Nko3em5Pa2UxeTZSUjgyRFBDMzM4eFB5eU1aNW5JL0E4bFBEaUc1SmUxZTZT?=
 =?utf-8?B?dmNzb0hHN0NGWSthYjNWb05xMzZzczNlbWUzZHlBMFc3Sll1NHNIa0JrcnBO?=
 =?utf-8?B?Wi85dlI4N0hNaGpsd3FKZkp2V09KSHMxUVhtTnAzZWdKc1NlMDIzSWV0YWVi?=
 =?utf-8?B?d2hYbXNNcC9OQVdVS2NTVE94NE5KQ3BzMWlVRmdHUlltTzVXQk1DSHBva1FD?=
 =?utf-8?B?WVVwTmV1SVRHb3ByZTZ2b2JHVi9oWE1PcVdlUVFCbHVoMkNKMlVzNjdqNmFt?=
 =?utf-8?B?MWliTzk0cUliU3k4RURBTkRzTjdxM253Z3MwQ1ErWmVYOXM4RnpSYXN4TFhS?=
 =?utf-8?B?eFFienhFRjkzbTJDakNHbjJiM2hsS0lPNkNCUkRVV2EwY2NkOStnNUxDQWN5?=
 =?utf-8?B?N3NJVjM4Z3RkaUtYdmpTaDQ4Skc2QStRdWROL05CV0RmWUViWXdUeGVncDhu?=
 =?utf-8?B?eVBnamV0SllDWE05WjdtMTRnOFNRaTVyWG9qckZJU08xKytJYi95YVEzREMv?=
 =?utf-8?B?NG5Eakk5aXlFSjIyQkdIQkZPRjk4OS9WWjA4Qk5WVEVYUXdwZWwzZjFndUIx?=
 =?utf-8?B?NVE0Z053YWJnLzVNUURHalc4UzgrQSs0dkZnS0VUTEtVNTNqdi9wWUZ6R0wr?=
 =?utf-8?B?Zytldk5USXdaMktkekcxUFhnNHl1T1ZHTXdoMWZjY3IrNGZLQXBDMkkxRzU4?=
 =?utf-8?B?VGk5U2xwRm9BalJZM3M3WERjd3FkV1ViMEZWdU0rSlFqdFFyazc0aWY2Vk4r?=
 =?utf-8?B?RVAxeDVNeHppTmxaOUhnMUwva0xqUHRlQTJWS3pRUEZtakl6aU5NLytUOGpi?=
 =?utf-8?B?VVU2dVAyanM1b3I2cVcydDN1K2VBcit0NTBzM0Zia0pTSDVVOGVZWmtkSUM3?=
 =?utf-8?B?LzFJakljY296KzlZU0EycUg1d3Q5RmdBTGtFUEZ0N1Z2RXJJZW5Za3dYS2h1?=
 =?utf-8?B?V3ZTcVE2cFN0ZFhXSjZ6QUpiZE5XLy9ZUDc3a25sMWlSNFVMTjR3ekU1UTZ6?=
 =?utf-8?B?ZmhyNHhNemx4TGRWV3pWbEFBTTRWRURCaU5VY0IzTjJoNk84Q1BZSWVXSG50?=
 =?utf-8?B?bWdPa3pNV0ZSTGpmNWxmNXJTYytPNzJCYXUxRWM5ZU12ZjhBNnpWRnh2d1l6?=
 =?utf-8?B?Sk01WWIrY01EVkxJdlVDbDNlVDdqU0diZGk1d1J5OW84bFd5Sko1dEtWb1Z5?=
 =?utf-8?B?M2tCb0FjbUhRVGVrOFUwWkpFNHdYV2hyZy9CQVVaRzVFYkFLZkNuWHkxbktr?=
 =?utf-8?B?RG5SUFNKeGQvRzQ5ZzhLbnA0VjJLVFM4UU1sWVJ6aXQ1OTNvRlZRK0V6cm1w?=
 =?utf-8?B?SDRpYVFZU1VWUmRCUWNlT1I1bEdzV1EzUWh0SE93TWlsM1gwUm12dmZ6NUZB?=
 =?utf-8?B?ZVVmMGpFNnE3MlFlMHZNcVlvSXpTOUpNTlN2QjBWNFRzdVlpOXY2bFNuSVpM?=
 =?utf-8?B?ZTc5UzlaVEhqMmxGdE5rTmNUbHZyUjJBZ05aRXJDZEVrRWdsd09lcGJ2M0JG?=
 =?utf-8?Q?C0EAV6/e39RPZF8vizuayRtE5CAN060yWJq3XqK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f157707-7927-4b67-3de0-08d8d2c6c9e2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2119.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 22:04:11.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDqWD0yE93D+Hw2esTNUYYMvT4tEa3ea6u3TeCRS58z+N3FAKONrIcTIR7dnY5/KdYZ1mCGyw19BSl3OXTyIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2213
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160175
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160176
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--NfzQdLJiLupm9ibYaXydn4rs2MYDq6YF1
Content-Type: multipart/mixed; boundary="YKGelao1VitDZ0gA1Cmz0TktmqCXiY1XX";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: "J. Bruce Fields" <bfields@redhat.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org
Message-ID: <47d31c15-7467-6abb-9e62-96ffca1c6ec0@oracle.com>
Subject: [RFC] pynfs: add courteous server tests

--YKGelao1VitDZ0gA1Cmz0TktmqCXiY1XX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

hi Bruce,

At Chuck's suggestion, I've added an initial PyNFS test to aid work on a =

courteous server. A simple test, along the lines you indicated, that=20
locks a file, waits twice the lease period, and tries to unlock:

OK -> PASS (courteous server)
BADSESSION -> WARNING (discourteous server)


Before sending my patch, Chuck asked me to add the second test you=20
suggested:

	- A second test creates a new client, acquires a file lock, and
	  waits two lease periods.  Then creates a second client, which
	  attempts to acquire the lock.  The second client should
	  succeed.



This doesn't seem to differentiate between these three cases:

1. a discourteous server, which invalidates the client 1 state, and=20
frees all client 1's locks, upon lease expiry, then allows client 2 to=20
lock the file. The above test spec would result in a PASS for a=20
discourteous server, which doesn't seem right.

2. a broad-grained courteous server, which invalidates the client 1=20
state, and frees all client 1's locks, because of conflicting access=20
from client 2 (after client 1's lease expiry), who is then granted the=20
lock. A PASS here would be correct.

3. a fine-grained courteous server, which persists the session, but=20
revokes that particular client 1 lock, because of conflicting access=20
from client 2 (after client 1's lease expiry), who is granted the lock.=20
A PASS here would be correct.

Or am I misreading your suggestion?


If I've read it right, the test could differentiate between cases 2) and =

3), by having client 1 try to unlock, after client 2 successfully locks, =

where client 1 will see either BADSESSION (case 2) or SOME_STATE_REVOKED =

/ EXPIRED (case 3). But we don't need to differentiate cases 2) and 3),=20
since a PASS would be correct in either case.

However that won't differentiate between cases 1) and 2), where client 1 =

will see BADSESSION in each case. Yet case 1) ought to result in a=20
WARNING, and case 2) in a PASS?


cheers,
calum.

--YKGelao1VitDZ0gA1Cmz0TktmqCXiY1XX--

--NfzQdLJiLupm9ibYaXydn4rs2MYDq6YF1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmAsQVUFAwAAAAAACgkQhSPvAG3BU+LV
LQ/+NpJUUmo/NmXE1mSXiclSPpE5bsMu7LDWieBXVzKAxKkRySrl6heoXdv43lUdLo7Odj8/q63l
szvDcrogcA0DItwqMZpXIaZqmcetE3J424XqjeGfTEgiB5rWDGz6yJV7xGXhAUsrAvHTwROvN7V8
zSe4JM1fNwnoP2iCd0Ph2BTYQqjkTanBy23EeRGQ9EKWnBLn/rfiAMiZHuT33BB3Kp1qZE3KP1mz
LgYD/q91JYvJRsyVohO23fJOoOaVpxfB15cmCHwgS+vSsE2x9kGpoWZpQccOh2IFu90eRj3vMEkr
WUnUZtVISbYtOEFTU0yED4eVsXAAxpp8TLdEY5q0Uh6yDKeYZjDmEpfMXr2QUOz+uLJzkq/FmHzj
WKX2oGG7y0qKCiyeTyV43hJKmb3bBB8XgwLIt6VXjUHhqMG6CSIxr/zYvryg7ILkMi3vc5nTKcKo
c96CThIUxKYu45ENDYO0+shC0FwOEb6TcWf/J7D70IQpetLN4CvUkyzSpYImIBG74iePnWGunDmo
pp6IhTdYa/VXDqLASvx5e8Y79XC3zHk7UkQUc33pu+d5FbDjU6xK6K0rFA7fkNRnNmadGUCjZ3Ab
gv9rIHktxxAjS/T261ZdCSh0C9LP+kLQzsrXWEGZnr3MUd3Z73u/syeJ48KV4Ln/YEM/1gk1vQDb
0lg=
=Zy7/
-----END PGP SIGNATURE-----

--NfzQdLJiLupm9ibYaXydn4rs2MYDq6YF1--
