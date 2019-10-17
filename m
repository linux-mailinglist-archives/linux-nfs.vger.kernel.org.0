Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF99DA4D1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 06:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbfJQEoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 17 Oct 2019 00:44:02 -0400
Received: from mail-eopbgr670083.outbound.protection.outlook.com ([40.107.67.83]:34649
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407756AbfJQEoC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlG0aDZfZJJAn0eEQNNK9WgHllQAhHmMhEPeminaQ3sPt9OMNn0UJiJHo44aIm20DC7xHp7HN1hSuwNp6m7PPR5Zvh7Xc/ZMEDsinxNhdxC8u8btJsoCpq7bXj02ulESvwmZ0YddvIAoGywTPr+FM7lak/A5yCN5hVQv/Bzd4cIymBwUL69SpjA1Ay8DP4K5E7fp0b/soxXRR67eSyMkjDz85/n6KMrq7WTfMUT7ysmOX5LKfv03ghCJGe27bfp8KLyAK+eR6yB8Dqu45u+D7peCiQHjjtKfT7uZH8mnsj9Jx19J8bU3xktwap7KtLkC7ue/eERyYsB/DMbibvKLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOBd75QQnB9K20lshF6uY8zcUawhMGb4W5rW3wtnRFQ=;
 b=VW1fwghsX7nnan5wWoafN8EtGc7zO6edEox9VIOwoZZTtzFfOW4vzSaOweCkK+rk6WPvzD3rN3dKneKtiz4UQ8QdCPRIcJ8IgpzffY+0mw9i6avrTVhuejRHcwguUa0DZq15gcR72THXAkdAih1rZ19hUcVkVIfO7prL7bhorArhdb9SnDsy1ZS70Zs1xBXL+Zxf6RC+7dm1CVroHJWiIasJ1CJM+gL3znbDQg5HkNViZrKniSee3ipCnARbBeNkZOTSgRUIxB3F4I7njcybjx8ezO7FRQAJzFpxlUavIzxGaKcCIqUrcL3FMADHr99FsGc5X7t4PxrVXw99oDzopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM (52.132.66.144) by
 YQBPR0101MB0948.CANPRD01.PROD.OUTLOOK.COM (52.132.65.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 17 Oct 2019 04:43:59 +0000
Received: from YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3]) by YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9051:db7:40f3:2ba3%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 04:43:59 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nfsv4@ietf.org" <nfsv4@ietf.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Thread-Topic: NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVg8vy6XBow5lmmE6IMuCp/6tuzqdcytI+gACiuwCAAEGxgIAACqQAgABZSj+AAC45/Q==
Date:   Thu, 17 Oct 2019 04:43:58 +0000
Message-ID: <YQBPR0101MB16526D76EE6A574D31EDF9DBDD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
 <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>,<20191016203150.GC17543@fieldses.org>,<YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQBPR0101MB16524CABD71AACBD2D9DC651DD6D0@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rmacklem@uoguelph.ca; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b532b86-b219-4ae1-3cde-08d752bca025
x-ms-traffictypediagnostic: YQBPR0101MB0948:
x-microsoft-antispam-prvs: <YQBPR0101MB0948583B9DA8A1928E5C23D3DD6D0@YQBPR0101MB0948.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(51444003)(199004)(189003)(66476007)(76116006)(478600001)(11346002)(74316002)(64756008)(86362001)(71200400001)(66946007)(71190400001)(476003)(8936002)(8676002)(186003)(66446008)(66556008)(81156014)(81166006)(102836004)(486006)(446003)(2906002)(33656002)(305945005)(5660300002)(54906003)(110136005)(99286004)(6506007)(14454004)(786003)(76176011)(6246003)(256004)(52536014)(46003)(316002)(53546011)(14444005)(9686003)(229853002)(25786009)(55016002)(4326008)(6436002)(2940100002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:YQBPR0101MB0948;H:YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: uoguelph.ca does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RDZgT0Jwx04MwzFVArFHsF/CRV12EJ4sHnh2uZ5wc/4XZLCVwechUTjLjTyxSEoQrLCKpSDluoBUpzjJl+ZRtChoimdAXNLNpsrOCWBxjGRYXP2lt/QJBRbiT4yoLpk3eZP/aj5lECBoXHiHKehQpwBoY7RoT1xHUmwsz3f5EmX3RbABF7l+l14eZoNdgsbgD9HOFl3p5Uvate0Xkkin3+ucvR+RW0Jpfn87YIqIz+WMx0BzRTe9BTB+Qk4fHtJYE4QUvKIxeWdv4/cKZvUSPr0mFt4vCa36QaG780TG12wBb+TREYj3iu+M6zK4wTj+wsSlD6u6DFHTSPoPI/uoY4x9I2F9+1dZWHX6Lgr5XXrhRjEt+7cHca70UsoZWShGmS61bUYodVKTCxnwNiRe5tzqQM/o8IHKzSMVoK6pUE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b532b86-b219-4ae1-3cde-08d752bca025
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 04:43:58.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stdXW7FiJNNYFTXWuCBc8Jd5hrliCYSdvb/eb0YA9uqdpGg2MjFlnNpD6TlFZQA3mZsz7OgVFd6ofqTckcBrLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB0948
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rick wrote:
>I have added nfsv4@ietf.org to the cc list, since I think it is important that
>everyone involved in NFSv4.2 be aware of this.
>
>>J. Bruce Fields wrote:
>>On Wed, Oct 16, 2019 at 07:53:45PM +0000, Kornievskaia, Olga wrote:
>>> On 10/16/19, 11:58 AM, "J. Bruce Fields" <bfields@fieldses.org> wrote:
>>>     On Wed, Oct 16, 2019 at 06:22:42AM +0000, Rick Macklem wrote:
>>>     > It seems that the Copy reply with wr_count == 0 occurs when the
>>>     > client sends a Copy request with ca_src_offset beyond EOF in the
>>>     > input file.  (It happened because I was testing an old/broken
>>>     > version of my client, but I can reproduce it, if you need a
>>>     > bugfix to be tested. I don't know if the case of
>>>     > ca_src_offset+ca_count beyond EOF behaves the same?) --> The RFC
>>>     > seems to require a reply of NFS4ERR_INVAL for this case.
>>>
>>>     I've never understood that INVAL requirement.  But I know it's
>>>     been discussed before, maybe there was some justification for it
>>>     that I've forgotten.
>No longer overly relevant, since the RFC is now a published spec.
>(It may have just been consistent with the old copy_file_range(2) semantics?)
>
>>>
>>> Sigh, well, I don’t know if we should consider adding the check to the
>>> NFS server to be NFS spec compliant. VFS layer didn't want the check
>>> and instead the preference has been to keep read() semantics of
>>> returning a short read (when the len was beyond the end of the file or
>>> if the source) to something beyond the end of the file.
>>
>>I'm inclined to think the spec's just wrong.
>The RFC is not wrong, although it might not be your preferred semantic.
>(It would only be wrong if it was unimplementable.)
>
>As for patching the server, I am not sure if that is a good idea now or not?
>- I would like to see the Linux NFSv4.2 server conform to the RFC, however
>   it has already shipped in its current form.
>--> I think that all extant clients need to handle both reply semantics and,
>       once that is the case, patching the server to conform to the RFC would
>       be nice.
>
>I have now found two cases where the Linux NFSv4.2 server does not conform
>to RFC-7862. One is as above and the other is a reply to Seek of NFS4ERR_NXIO
>when the sa_offset argument == file_size (instead of replying NFS_OK along
>with sr_eof == true).
>
>Since I now know about these two cases, I can code the client to handle
>both of them. Of course, I do worry about others that I have not found yet.
>
>>And how else could a client possibly interpret a 0 return?
>The FreeBSD client looped, because it does a Copy in a loop until all bytes
>were copied and, with a reply length == 0, it didn't make progress or
>recognize an error.
>
>Fortunately, this client is still under development (not yet released), so I can
>add code to handle wr_count == 0 in the same way as NFS4ERR_INVAL.
>
>>> On the client if VFS did read of len=0 then VFS itself we return 0,
>>> thus this doesn't protect against other clients sending an NFS copy
>>> with len=0.  And in NFS, receiving copy with len=0 means copy to the
>>> end of the file. It's not implemented for any "intra" or "inter" code.
>Are you saying that an NFSv4.2 Copy request with a ca_count == 0
>will not work for the Linux NFSv4.2 server?
>(I guess I'd better test this one, too.)
Tested it and it does not work, at least for Fedora30.
The server just returns 0 instead of doing a copy to EOF on the input file.
I think you should implement this, although my client does not do this now.

>>A call with len=0 sounds like a different case.
Yes, as above.
>>
>>--b.

rick

